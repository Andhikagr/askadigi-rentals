import 'package:car_rental/help/help.dart';
import 'package:flutter/material.dart';

Widget buttonOne(BuildContext context, String label, VoidCallback onTap) {
  return Material(
    borderRadius: BorderRadius.circular(20),
    color: Colors.transparent,
    child: InkWell(
      onTap: () {},
      splashColor: Colors.white.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(30),
      child: Ink(
        width: double.infinity,
        height: context.deviceHeight * 0.065,
        decoration: BoxDecoration(
          color: const Color(0xFF1382DC),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade100,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}
