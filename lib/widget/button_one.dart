import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/help.dart';
import 'package:flutter/material.dart';

Widget buttonOne(BuildContext context, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: context.deviceHeight * 0.065,
      decoration: BoxDecoration(
        color: primaryColor(context),
        borderRadius: BorderRadius.circular(20),
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
