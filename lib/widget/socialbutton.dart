import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:flutter/material.dart';

Widget socialButton(BuildContext context, String image, String label) {
  return Container(
    padding: EdgeInsets.all(context.shortp(0.03)),
    width: context.shortp(0.35),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, fit: BoxFit.cover, width: context.shortp(0.07)),
        SizedBox(width: context.shortp(0.015)),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: onInverseSurfaceColor(context)),
        ),
      ],
    ),
  );
}
