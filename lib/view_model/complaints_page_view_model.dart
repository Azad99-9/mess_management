import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mess_management/model/complaint_model.dart';
import 'package:mess_management/services/db_service.dart';
import 'package:mess_management/services/user_service.dart';
import 'package:stacked/stacked.dart';

class ComplaintsPageViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedCategory;
  List<String> categories = ['Food', 'Hygiene', 'Service', 'Other'];
  String? attachmentPath;

  BuildContext? context;

  void updateSelected(value) {
    selectedCategory = value!;
    notifyListeners();
  }

  void submitComplaint() async {
    if (formKey.currentState!.validate()) {
      notifyListeners();
      final title = titleController.text;
      final description = descriptionController.text;
      final category = selectedCategory;
      final attachment = attachmentPath;
      String? downloadUrl;

      // Handle complaint submission logic (e.g., API call)
      if (attachment != null) {
        final storageRef = FirebaseStorage.instance.ref().child('complaints/${DateTime.now().millisecondsSinceEpoch}.jpg');

        final uploadTask = storageRef.putFile(File(attachment));

        await uploadTask;

        downloadUrl = await storageRef.getDownloadURL();
      }

      await DBService.complaints.add(ComplaintModel(
        uid: UserService.currentUser!.uid,
        category: category ?? '',
        description: description ?? '',
        title: title ?? '',
        uploadUrl: downloadUrl ?? '',
      ).toJson());

      ScaffoldMessenger.of(context!).showSnackBar(
       const SnackBar(content: Text('Complaint submitted successfully!')),
      );

      // Clear the form after submission
      titleController.clear();
      descriptionController.clear();
      selectedCategory = null;
      attachmentPath = null;

      notifyListeners();
    }
  }

  Future<void> pickAttachment() async {
    final ImagePicker picker = ImagePicker();

    try {
      // Pick an image
      final XFile? pickedFile =
      await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
          attachmentPath = pickedFile.path; // Store the picked image path
      } else {
        // User canceled the picker
         attachmentPath = null;
      }
    } catch (e) {
      // Handle any errors
      print('Error picking image: $e');
    }
    print(attachmentPath);
    notifyListeners();
  }

}