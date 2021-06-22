import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/bloc_observer.dart';
import 'package:shop_app/layouts/home_layout_screen.dart';
import 'package:shop_app/screens/onboarding_screen.dart';
import 'package:shop_app/screens/shop_login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();

  Widget widget;

  bool isOnBoarding = CacheHelper.getData(key: "onBoarding");
  String token = CacheHelper.getData(key: "token");

  if (isOnBoarding != null) {
    if (token != null)
      widget = HomeLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange[400],
        fontFamily: "Roboto",
        buttonTheme: ButtonThemeData(buttonColor: primaryColor),
      ),
      home: startWidget,
    );
  }
}
