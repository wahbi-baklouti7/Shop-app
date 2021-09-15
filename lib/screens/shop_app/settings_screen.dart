import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shopapp/shop_cubit.dart';
import 'package:shop_app/screens/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context).userModel;
        nameController.text = cubit.data.name;
        emailController.text = cubit.data.email;
        phoneController.text = cubit.data.phone;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFromValidation(
                    controller: nameController,
                    label: "Name",
                    prefixIcon: Icons.person,
                    textInputType: TextInputType.name,
                    validation: (String value) {
                      if (value.isEmpty) {
                        return "Name must be not empty";
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: 24,
                ),
                defaultFromValidation(
                    controller: emailController,
                    label: "Email",
                    prefixIcon: Icons.email,
                    textInputType: TextInputType.emailAddress,
                    validation: (String value) {
                      if (value.isEmpty) {
                        return "email must be not empty";
                      } else {
                        return null;
                      }
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
                        return "Phone must be not empty";
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: 24,
                ),
                RaisedButton(
                    child: Text("LogOut",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            letterSpacing: 1)),
                    onPressed: () async {
                      CacheHelper.removeData(key: "token").then((value) {
                        if (value) {
                          navigateAndFinish(context, ShopLoginScreen());
                          showToast(
                              message: cubit.message,
                              messageType: MessageType.SUCCESS);
                        }
                      });
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
