import 'package:shop_app/models/login_model.dart';

abstract class ShopLoginState {}

class ShopLoginStateInitial extends ShopLoginState {}

class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState {
  final LoginUserModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginState {
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopLoginChangePasswordState extends ShopLoginState {}
