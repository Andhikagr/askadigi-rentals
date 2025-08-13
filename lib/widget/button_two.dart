import 'package:flutter/material.dart';

class ButtonTwo extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Color colorBackground;
  final Color borderColor;
  final Color fontColor;

  const ButtonTwo({
    super.key,
    required this.label,
    required this.fontColor,
    this.onTap,
    required this.colorBackground,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorBackground,
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
          ),
        ),
      ),
    );
  }
}
