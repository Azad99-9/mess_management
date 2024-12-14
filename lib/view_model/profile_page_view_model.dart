import 'package:firebase_auth/firebase_auth.dart';
import 'package:mess_management/model/complaint_model.dart';
import 'package:mess_management/model/user_model.dart';
import 'package:stacked/stacked.dart';
import 'package:mess_management/services/user_service.dart';
import 'package:mess_management/locator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:mess_management/services/db_service.dart';
class ProfilePageViewModel extends BaseViewModel{

  BuildContext?context;
  String? attachmentPath;
   late  UserService _userService;
   UserModel?_currentUser;
   List<ComplaintModel>_complaints=[];
   UserModel?  get currentUser=>_currentUser;
   List<ComplaintModel> get complaints=>_complaints;

   bool isLoading = false;


   ProfilePageViewModel() {
     _userService = locator<UserService>();
     fetchUserComplaints();
   }
   void fetchCurrentUser() async {
     isLoading = true;
     notifyListeners();
     try {
       setBusy(true);
       final UserModel user = await _userService.fetchUserDoc();
       _currentUser = user;
       print(User);
     } catch (error) {
       print("Error fetching user data: $error");
     }
     finally{
       setBusy(false);
     }
     isLoading = false;
     notifyListeners();
   }
   void fetchUserComplaints() async {
     try {
       setBusy(true);
       final user = _userService.getUser;
       if (user != null) {  // Null check for user
         final querySnapshot = await DBService.complaints.where('uid', isEqualTo: user.uid).get();
         if (querySnapshot.docs.isNotEmpty) {
           List<ComplaintModel> complaintsList = [];
           for (var doc in querySnapshot.docs) {
             final complaintDetails = ComplaintModel.fromJson(doc.data() as Map<String, dynamic>);
             complaintsList.add(complaintDetails);
           }
           _complaints = complaintsList;

           notifyListeners();
         } else {
           print("No complaints exist.");
         }
       } else {
         print("User is not authenticated.");
       }
     } catch (error) {
       print("Error fetching complaints data: $error");
     } finally {
       setBusy(false);
     }
   }

   Future<void> pickAttachment() async {
     final ImagePicker picker = ImagePicker();

     try {
       // Pick an image
       final XFile? pickedFile =
       await picker.pickImage(source: ImageSource.gallery);

       if (pickedFile != null) {
         attachmentPath = pickedFile.path;
         _showMyDialog(attachmentPath!);
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

  Future<void> _showMyDialog(String attachment) async {
    return showDialog<void>(
      context: context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Profile'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Would you like to update your profile picture?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () async {
                if (attachment != null) {
                  try {
                    final storageRef = FirebaseStorage.instance
                        .ref()
                        .child('profile_pictures/${DateTime.now().millisecondsSinceEpoch}.jpg');
                    final uploadTask = storageRef.putFile(File(attachment));
                    await uploadTask;

                    final user = _userService.getUser;
                    if (user != null) {
                      String downloadUrl = await storageRef.getDownloadURL();
                      print("downloadURL $downloadUrl");
                      await DBService.users.doc(user.uid).update({'imageURL': downloadUrl});

                      // Update local state
                      notifyListeners();
                      ScaffoldMessenger.of(context!).showSnackBar(
                        const SnackBar(content: Text('Profile updated successfully!')),
                      );
                    }
                  } catch (error) {
                    print('Error updating profile picture: $error');
                    ScaffoldMessenger.of(context!).showSnackBar(
                      const SnackBar(content: Text('Failed to update profile. Please try again.')),
                    );
                  } finally {
                    Navigator.of(context).pop(); // Close dialog
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

}