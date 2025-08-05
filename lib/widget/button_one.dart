import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:flutter/material.dart';

Widget buttonOne(BuildContext context, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.all(context.shortp(0.02)),
      width: double.infinity,
      height: context.shortp(0.16),
      decoration: BoxDecoration(
        color: inverseSurfaceColor(context),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: inverseSurfaceColor(context).withValues(alpha: 0.5),
            blurRadius: 3,
            spreadRadius: 1,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: onPrimaryColor(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
