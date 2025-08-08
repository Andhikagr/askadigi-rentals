import 'package:car_rental/core/constant/colors.dart';
import 'package:flutter/material.dart';

Widget buttonOne(BuildContext context, String label, VoidCallback onTap) {
  return Center(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: 400,
        height: 60,
        decoration: BoxDecoration(
          // color: onInverseSurfaceColor(context),
          color: Color(0xFF003984),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: onInverseSurfaceColor(context),
            ),
          ),
        ),
      ),
    ),
  );
}
