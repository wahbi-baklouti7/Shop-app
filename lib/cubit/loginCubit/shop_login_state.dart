abstract class ShopLoginState {}

class ShopLoginStateInitial extends ShopLoginState {}

class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState {}

class ShopLoginErrorState extends ShopLoginState {
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopLoginChangePasswordState extends ShopLoginState {}
