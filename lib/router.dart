import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mess_management/constants/routes.dart';
import 'package:mess_management/main.dart';
import 'package:mess_management/views/menu.dart';
import 'package:mess_management/views/signin_details_page.dart';
import 'package:mess_management/views/signin_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.signIn:
      return MaterialPageRoute(builder: (context) => SigninPage());

    case Routes.menu:
      return MaterialPageRoute(builder: (context) => MessMenuPage());

    case Routes.home:
      return MaterialPageRoute(builder: (context) => MainScreen());

    case Routes.signUp:
      return MaterialPageRoute(builder: (context) => SigninDetailsPage(userDetails: settings.arguments as User,));

    case Routes.splashScreen:
      return MaterialPageRoute(builder: (context) => SplashScreen());

    default:
      return MaterialPageRoute(builder: (context) => Container());
  }
}
