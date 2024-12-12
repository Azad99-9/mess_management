import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mess_management/constants/routes.dart';
import 'package:mess_management/locator.dart';
import 'package:mess_management/model/user_model.dart';

class SigninDetailsViewModel extends ChangeNotifier {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController genderController;
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();

  late final User userDetails;

  void initialise(User user) {
    userDetails = user;
    nameController = TextEditingController(text: userDetails.displayName ?? '');
    emailController = TextEditingController(text: userDetails.email);
    phoneController = TextEditingController(text: userDetails.phoneNumber);
    genderController = TextEditingController();
  }

  void submit() async {
    nameFocus.unfocus();
    emailFocus.unfocus();
    phoneFocus.unfocus();
    try {
      await userService.createNewUser(
        UserModel(
            uid: userDetails.uid,
            name: nameController.text,
            email: emailController.text,
            phoneNumber: phoneController.text,
            gender: genderController.text),
      );
      navigationService.pushScreen(Routes.menu);
    } catch (e) {
      print(e.toString());
    }
  }
}
