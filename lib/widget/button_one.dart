import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:car_rental/core/constant/colors.dart';

Widget buttonOne(BuildContext context, String label, VoidCallback onTap) {
  return Center(
    child: GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: 180,
            height: 55,
            decoration: BoxDecoration(
              border: Border.all(color: outlineVariantColor(context), width: 2),
              color: Colors.grey.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(10),
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
      ),
    ),
  );
}
