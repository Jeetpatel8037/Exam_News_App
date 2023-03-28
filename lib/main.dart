import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Views/Home_Page.dart';

import 'Views/Intro_Screens.dart';
import 'Views/Register_Page.dart';
import 'Views/Sign_In_Page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool? isIntroVisited = prefs.getBool("isIntroVisited") ?? false;
  bool? isLogin = prefs.getBool("isLogin") ?? false;
  bool? isRemember = prefs.getBool("isRemember") ?? false;
  runApp(
    MaterialApp(
      initialRoute: (isIntroVisited == false)
          ? "intro_page"
          : (isLogin == false)
          ? "user_details_screens"
          : (isRemember == false)
          ? "login_page"
          : "/",
      routes: {
        "/": (context) => const HomePage(),
        "login_page": (context) => const LoginPage(),
        "intro_page": (context) => const IntroPage(),
        "user_details_screens": (context) => const UserDetails(),
       // "OfflineNews": (context) => const OfflineNews(),
      },
    ),
  );
}
