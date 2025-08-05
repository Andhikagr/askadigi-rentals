import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/help.dart';
import 'package:flutter/material.dart';

Widget socialButton(BuildContext context, String image, String label) {
  return Container(
    padding: EdgeInsets.all(context.deviceWidth * 0.03),
    height: context.deviceHeight * 0.06,
    width: context.deviceWidth * 0.4,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: surfContainerColor(context),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, fit: BoxFit.cover),
        SizedBox(width: context.deviceWidth * 0.03),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    ),
  );
}
