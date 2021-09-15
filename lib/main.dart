import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/bloc_observer.dart';
import 'package:shop_app/cubit/shopapp/shop_cubit.dart';
import 'package:shop_app/layouts/home_layout_screen.dart';
import 'package:shop_app/screens/onBoarding/onboarding_screen.dart';
import 'package:shop_app/screens/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
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
  token = CacheHelper.getData(key: "token");
  print(token);

  if (isOnBoarding != null) {
    if (token != null)
      widget = HomeLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..getHomeData()
        ..getCategoriesData()..getFavoritesData()..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.orange[400],
          fontFamily: "Roboto",
          buttonTheme: ButtonThemeData(buttonColor: primaryColor),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              unselectedItemColor: Colors.grey[500],
              type: BottomNavigationBarType.shifting,
              showUnselectedLabels: true,
              selectedItemColor: primaryColor),
        ),
        home: startWidget,
      ),
    );
  }
}
