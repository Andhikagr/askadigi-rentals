import 'package:car_rental/core/constant/colors.dart';
import 'package:flutter/material.dart';

Widget buttonThree(BuildContext context, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        // color: onInverseSurfaceColor(context),
        color: Color(0xFF003984),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: onInverseSurfaceColor(context),
          ),
        ),
      ),
    ),
  );
}
