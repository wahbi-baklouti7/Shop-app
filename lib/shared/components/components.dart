import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit/shopapp/shop_cubit.dart';
import 'package:shop_app/models/onboarding_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

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
  final bool obscure = false,
  Function suffixPress,
  Function onSubmit,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscure,
    keyboardType: textInputType,
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
      prefixIcon: Icon(prefixIcon),
      suffixIcon: IconButton(
        icon: Icon(suffixIcon),
        onPressed: suffixPress,
      ),
      labelText: label,
      hintText: hintText,
    ),
    validator: validation,
    onFieldSubmitted: onSubmit,
  );
}

// ignore: missing_return
Widget navigateAndFinish(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

// ignore: missing_return
Widget showToast(
    {@required String message, @required MessageType messageType}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: chooseMessageColor(messageType),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum MessageType { SUCCESS, WARNING, ERROR }

Color chooseMessageColor(MessageType messageType) {
  Color color;

  switch (messageType) {
    case MessageType.SUCCESS:
      color = Colors.green;
      break;
    case MessageType.ERROR:
      color = Colors.red;
      break;
    case MessageType.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

Widget buildItems(model, context, {bool isfavorite = true}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 120,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Image(
              image: NetworkImage("${model.image}"),
              width: 150,
              height: 150,
              // fit: BoxFit.cover,
            ),
            if (model.discount != 0)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                child: Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Discount",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              )
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model.name}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14),
              ),
              Spacer(),
              Row(
                children: [
                  //product price
                  Text(
                    "${model.price.toString()}",
                    maxLines: 2,
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  if (model.discount != 0 && isfavorite)
                    //old price
                    Text(
                      '${model.oldPrice.toString()}',
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                      iconSize: 30,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        ShopCubit.get(context)
                            .changeFavorites(productId: model.id);
                      },
                      icon: CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id]
                                  ? primaryColor
                                  : Colors.grey,
                          child: Icon(Icons.favorite_border,
                              color: Colors.white))),
                ],
              ),
            ],
          ),
        )
      ]),
    ),
  );
}
