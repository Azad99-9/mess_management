import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mess_management/constants/routes.dart';
import 'package:mess_management/locator.dart';
import 'package:mess_management/services/notification_services.dart';
import 'package:mess_management/services/theme_service.dart';
import 'package:mess_management/services/size_config.dart';
import 'package:mess_management/services/user_service.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: ThemeService.secondaryColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.screenHeight * 0.35,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: SizeConfig.screenHeight * 0.1,
                    left: SizeConfig.screenWidth * 0.3,
                    child: CircleAvatar(
                      key: const Key('Profile Pic'),
                      backgroundImage: const NetworkImage(
                          'https://th.bing.com/th/id/OIP.D2Gzy7GXSgpAshfRx9tkHAHaHa?rs=1&pid=ImgDetMain'),
                      radius: SizeConfig.screenHeight * 0.09,
                    ),
                  ),
                  Positioned(
                    top: SizeConfig.screenHeight * 0.28,
                    left: SizeConfig.screenWidth * 0.05,
                    child: const Text(
                      "Mess Management System",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.05,
            ),
            Text(
              "Sign In",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.05,
            ),
            ElevatedButton(
              onPressed: () async {
                final userData = await userService.googleSignIn();
                if (userService.loggedIn) {
                  final docRef = FirebaseFirestore.instance.collection('users').doc(userData?.uid);
                  final DocumentSnapshot snapshot = await docRef.get();
                  if (!snapshot.exists) {
                    navigationService.pushScreen(Routes.signUp, arguments: userData);
                  } else {
                    final FCS_TOKEN=await NotificationServices().getToken();
                    print("in sign in page $FCS_TOKEN");
                    await docRef.update({
                      'FCS_TOKEN':FCS_TOKEN
                    });
                    navigationService.pushScreen(Routes.menu);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                maximumSize: const Size(300, 200),
                minimumSize: const Size(100, 50),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: ThemeService.primaryTextColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(
                        'https://th.bing.com/th/id/OIP.IcreJX7hnOjNYRnlo4DCWwHaE8?rs=1&pid=ImgDetMain'),
                  ),
                  Text(
                    "Continue with Google",
                    style: TextStyle(
                      fontSize: 18,
                      color: ThemeService.primaryTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),
            Text("Or"),
            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already have an account ? ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    print(userService.loggedIn);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ThemeService.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
