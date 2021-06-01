import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/bloc_observer.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/screens/onboarding_screen.dart';
import 'package:shop_app/shared/styles/colors.dart';

void main() {
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
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
        buttonTheme: ButtonThemeData(buttonColor: primaryColor),
      ),
      home: OnBoardingScreen(),
    );
  }
}
