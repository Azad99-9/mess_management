import 'package:flutter/material.dart';

class SigninDetailsViewModel extends ChangeNotifier {
  final TextEditingController nameController=TextEditingController(text: "Sayyad Asifbasha");
  final TextEditingController emailController=TextEditingController(text:"asifbasha4873@gmail.com");
  final TextEditingController phoneController=TextEditingController();
  final TextEditingController genderController=TextEditingController(text: "male");
  FocusNode nameFocus=FocusNode();
  FocusNode emailFocus=FocusNode();
  FocusNode phoneFocus=FocusNode();

  void submit()
  {
    nameFocus.unfocus();
    emailFocus.unfocus();
    phoneFocus.unfocus();
    print(nameController.text);
    print(emailController.text);
    print(phoneController.text);
    print(genderController.text);
  }
}