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
