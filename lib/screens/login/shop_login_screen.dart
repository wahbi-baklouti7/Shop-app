import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/loginCubit/shop_login_cubit.dart';
import 'package:shop_app/cubit/loginCubit/shop_login_state.dart';
import 'package:shop_app/layouts/home_layout_screen.dart';
import 'package:shop_app/screens/login/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

// ignore: must_be_immutable
class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
          listener: (context, state) {
            if (state is ShopLoginSuccessState) {
              if (state.loginModel.status) {
                showToast(
                    message: state.loginModel.message,
                    messageType: MessageType.SUCCESS);
                CacheHelper.saveData(
                        key: "token", value: state.loginModel.data.token)
                    .then((value) {
                  navigateAndFinish(context, HomeLayout());
                  token = state.loginModel.data.token;
                  
                });
              } else {
                showToast(
                    message: state.loginModel.message,
                    messageType: MessageType.ERROR);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        defaultFromValidation(
                            obscure: false,
                            controller: emailController,
                            label: "Email Address",
                            prefixIcon: Icons.email,
                            textInputType: TextInputType.emailAddress,
                            validation: (String value) {
                              if (value.isEmpty) {
                                return "Please! Enter your email address";
                              }
                              return null;
                            }),
                        SizedBox(height: 24),
                        defaultFromValidation(
                            obscure: ShopLoginCubit.get(context).obscure,
                            controller: passwordController,
                            label: "Password",
                            prefixIcon: Icons.lock,
                            suffixIcon: ShopLoginCubit.get(context).suffix,
                            suffixPress: () {
                              ShopLoginCubit.get(context).changePassword();
                            },
                            textInputType: TextInputType.visiblePassword,
                            validation: (String value) {
                              if (value.isEmpty) {
                                return "Please! Enter your password";
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 24,
                        ),
                        BlocBuilder<ShopLoginCubit, ShopLoginState>(
                          builder: (context, state) {
                            if (state is ShopLoginLoadingState) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0)),
                              height: 56,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                  child: Text("LOGIN",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                          letterSpacing: 1)),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                      // CacheHelper.sharedPreferences.saveData();
                                    }
                                  }),
                            );
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w200),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            defaultTextButton(
                                text: Text("Register Now",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange)),
                                function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShopRegisterScreen()));
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
