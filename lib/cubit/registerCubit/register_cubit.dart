import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/registerCubit/register_state.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginUserModel registerModel;
  void userRegister(
      {@required name, @required email, @required phone, @required password}) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: registerUrl, data: {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password
    }).then((value) {
      registerModel = LoginUserModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(RegisterErrorState());
    });
  }

  bool isObscure = true;
  IconData suffix = Icons.visibility_off;
  void changePassword() {
    print("after press: $isObscure");
    isObscure = !isObscure;
    suffix = isObscure ? Icons.visibility_off : Icons.visibility;
    emit(RegisterChangePasswordState());
    print("before press: $isObscure");
  }
}
