import 'package:flutter/material.dart';
import 'package:shop_app/screens/onboarding_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange[400],
        fontFamily: "Roboto",
      ),
      home: OnBoardingScreen(),
    );
  }
}
