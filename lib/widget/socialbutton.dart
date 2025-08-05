import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:flutter/material.dart';

Widget socialButton(BuildContext context, String image, String label) {
  return Padding(
    padding: EdgeInsets.all(context.shortp(0.02)),
    child: Container(
      padding: EdgeInsets.all(context.shortp(0.03)),
      width: context.shortp(0.3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: surfContainerColor(context),
        boxShadow: [
          BoxShadow(
            color: inverseSurfaceColor(context).withValues(alpha: 0.15),
            blurRadius: 6,
            spreadRadius: 1,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, fit: BoxFit.cover, width: context.shortp(0.07)),
          SizedBox(width: context.shortp(0.015)),
          Text(label, style: TextStyle(fontSize: 14)),
        ],
      ),
    ),
  );
}
