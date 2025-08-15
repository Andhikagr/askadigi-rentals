import 'package:car_rental/core/constant/colors.dart';
import 'package:flutter/material.dart';

Widget buttonThree(BuildContext context, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xFF003984),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            offset: Offset(2, 3),
            blurRadius: 1,
          ),
        ],
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
