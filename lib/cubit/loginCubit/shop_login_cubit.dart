import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/loginCubit/shop_login_state.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginStateInitial());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  LoginUserModel loginModel;

  userLogin({@required email, @required password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: login, data: {"email": email, "password": password})
        .then((value) {
      loginModel = LoginUserModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
      print(error.toString());
    });
  }

  bool obscure = true;
  IconData suffix = Icons.visibility_off;
  void changePassword() {
    obscure = !obscure;
    suffix = obscure ? Icons.visibility : Icons.visibility_off;
    emit(ShopLoginChangePasswordState());
  }
}
