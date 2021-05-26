import 'package:flutter/material.dart';
import 'package:shop_app/models/onboarding.dart';


Widget buildOnboardingItem(OnBoarding model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(image: AssetImage("${model.image}"),fit: BoxFit.cover),
        SizedBox(
          height: 20,
        ),
        Text(model.heading,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,letterSpacing: 0.5)),
        SizedBox(
          height: 16,
        ),
        Text(model.body,textAlign: TextAlign.center,style: TextStyle(color: Colors.grey[500]))
      ],
    );
  }