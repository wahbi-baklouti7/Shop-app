import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/registerCubit/register_cubit.dart';
import 'package:shop_app/cubit/registerCubit/register_state.dart';
import 'package:shop_app/screens/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopRegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.registerUser.status) {
              showToast(
                  message: state.registerUser.message,
                  messageType: MessageType.SUCCESS);
              navigateAndFinish(context, ShopLoginScreen());
            } else {
              showToast(
                  message: state.registerUser.message,
                  messageType: MessageType.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defaultFromValidation(
                          controller: nameController,
                          label: "Name",
                          prefixIcon: Icons.person,
                          textInputType: TextInputType.name,
                          validation: (String value) {
                            if (value.isEmpty) {
                              return "Please! Enter your name";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 24,
                      ),
                      defaultFromValidation(
                          controller: phoneController,
                          label: "Phone",
                          prefixIcon: Icons.phone,
                          textInputType: TextInputType.phone,
                          validation: (String value) {
                            if (value.isEmpty) {
                              return "Please! Enter your phone";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 24,
                      ),
                      defaultFromValidation(
                          controller: emailController,
                          label: "email",
                          prefixIcon: Icons.email,
                          textInputType: TextInputType.emailAddress,
                          validation: (String value) {
                            if (value.isEmpty) {
                              return "Please! Enter your email address";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 24,
                      ),
                      defaultFromValidation(
                          controller: passwordController,
                          obscure: RegisterCubit.get(context).isObscure,
                          suffixIcon: RegisterCubit.get(context).suffix,
                          suffixPress: () {
                            RegisterCubit.get(context).changePassword();
                          },
                          label: "Password",
                          prefixIcon: Icons.lock,
                          textInputType: TextInputType.name,
                          validation: (String value) {
                            if (value.isEmpty) {
                              return "Please! Enter your password";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 24,
                      ),
                      RaisedButton(
                          child: Text("Register",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white)),
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text);
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
