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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: ThemeService.secondaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
            const Text(
              "RGUKT",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xff00444E),
              ),
            ),
            const Text(
              "Mess Management System",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xff00444E),
              ),
            ),

            // SizedBox(
            //   height: SizeConfig.screenHeight * 0.35,
            //   child: Stack(
            //     children: <Widget>[
            //
            //     ],
            //   ),
            // ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.05,
            ),
            // Text(
            //   "Sign In",
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w800,
            //   ),
            // ),
            // SizedBox(
            //   height: 8,
            // ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                final userData = await userService.googleSignIn();
                if (userService.loggedIn) {
                  final docRef = FirebaseFirestore.instance
                      .collection('users')
                      .doc(userData?.uid);
                  final DocumentSnapshot snapshot = await docRef.get();
                  if (!snapshot.exists) {
                    navigationService.pushReplacementScreen(Routes.signUp,
                        arguments: userData);
                  } else {
                    final FCS_TOKEN = await NotificationServices().getToken();
                    print("in sign in page $FCS_TOKEN");
                    await docRef.update({'FCS_TOKEN': FCS_TOKEN});
                    navigationService.pushReplacementScreen(Routes.home);
                  }
                }
                setState(() {
                  isLoading = false;
                });
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(0),
                maximumSize: const Size(300, 200),
                minimumSize: const Size(100, 50),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),

                ),
              ),
              child: isLoading
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 30, height: 30, child: CircularProgressIndicator(),)
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(
                              'https://th.bing.com/th/id/OIP.IcreJX7hnOjNYRnlo4DCWwHaE8?rs=1&pid=ImgDetMain'),
                        ),
                        SizedBox(width: 8,),
                        Text(
                          "Continue with Google",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),

          ],
        ),
      ),
    );
  }
}
