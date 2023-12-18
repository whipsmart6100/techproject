import 'package:flutter/material.dart';

class NavigationRouter {
  static void switchToLogin(BuildContext context) {
    Navigator.pushNamed(context, "/LoginScreen");
  }

  static void switchToScan(BuildContext context) {
    Navigator.pushNamed(context, "/ScanScreen");
  }

  static void switchToHome(BuildContext context) {
    Navigator.pushNamed(context, "/HomeScreen");
  }
  static void switchToProfile(BuildContext context) {
    Navigator.pop(context, "/ProfileScreen");
  }
}