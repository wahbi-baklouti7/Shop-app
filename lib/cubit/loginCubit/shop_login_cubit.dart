import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/loginCubit/shop_login_state.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginStateInitial());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  userLogin({@required email, @required password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: login, data: {"email": email, "password": password})
        .then((value) {
      print(value);
      emit(ShopLoginSuccessState());
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  bool obscure = false;
  IconData suffix = Icons.visibility;
  void changePassword() {
    obscure = !obscure;
    suffix = obscure ? Icons.visibility_off : Icons.visibility;
    emit(ShopLoginChangePasswordState());
  }
}
