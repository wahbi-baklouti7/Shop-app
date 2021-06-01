import 'package:flutter/material.dart';
import 'package:shop_app/models/onboarding.dart';

Widget buildOnboardingItem(OnBoarding model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image(image: AssetImage("${model.image}"), fit: BoxFit.cover),
      SizedBox(
        height: 20,
      ),
      Text(model.heading,
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
      SizedBox(
        height: 16,
      ),
      Text(model.body,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[500]))
    ],
  );
}

TextButton defaultTextButton({
  @required Widget text,
  @required Function function,
}) {
  return TextButton(
    onPressed: function,
    child: text,
  );
}

Widget defaultFromValidation({
  @required TextEditingController controller,
  @required String label,
  @required IconData prefixIcon,
  @required TextInputType textInputType,
  Function validation,
  final IconData suffixIcon,
  final String hintText,
  final bool obscure,
  Function suffixPress,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscure,
    keyboardType: textInputType,
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
      prefixIcon: Icon(prefixIcon),
      suffixIcon: IconButton(icon:Icon(suffixIcon),onPressed: suffixPress,),

      
      labelText: label,
      hintText: hintText,
    ),
    validator: validation,
  );
}
