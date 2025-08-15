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
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorBackground,
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: Offset(0, 2),
              blurRadius: 0,
            ),
          ],
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
