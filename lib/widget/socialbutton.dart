import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:flutter/material.dart';

Widget socialButton(BuildContext context, String image, String label) {
  return Padding(
    padding: EdgeInsets.only(bottom: 20),
    child: Container(
      width: 180,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, fit: BoxFit.cover, width: 35),
          SizedBox(width: context.longp(0.015)),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: onInverseSurfaceColor(context),
            ),
          ),
        ],
      ),
    ),
  );
}
