import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mess_management/locator.dart';
import 'package:flutter/material.dart';
import 'package:mess_management/constants/routes.dart';
import 'package:mess_management/locator.dart';
import 'package:mess_management/model/user_model.dart';
import 'package:mess_management/services/notification_services.dart';

class SigninDetailsViewModel extends ChangeNotifier {
  bool isLoading = false;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController genderController;
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  late void Function(void Function() fn) _setState;

  late final User userDetails;

  void initialise(User user, void Function(void Function() fn) setState) {
    userDetails = user;
    nameController = TextEditingController(text: userDetails.displayName ?? '');
    emailController = TextEditingController(text: userDetails.email);
    phoneController = TextEditingController(text: userDetails.phoneNumber);
    genderController = TextEditingController();
    _setState = setState;
  }

  void submit() async {
    _setState(() {
      isLoading = true;
    });
    nameFocus.unfocus();
    emailFocus.unfocus();
    phoneFocus.unfocus();
    final FCS_TOKEN=await NotificationServices().getToken();
    try {
      await userService.createNewUser(
        UserModel(
            uid: userDetails.uid,
            name: nameController.text,
            email: emailController.text,
            phoneNumber: phoneController.text,
            gender: genderController.text,
            FCS_TOKEN: FCS_TOKEN,
        ),
      );
      navigationService.pushReplacementScreen(Routes.home);
    } catch (e) {
      print(e.toString());
    }
    _setState(() {
      isLoading = false;
    });
  }
}
