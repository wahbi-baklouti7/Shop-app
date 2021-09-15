import 'package:shop_app/models/login_model.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final LoginUserModel registerUser;
  RegisterSuccessState(this.registerUser);
}

class RegisterErrorState extends RegisterState {}

class RegisterChangePasswordState extends RegisterState {}
