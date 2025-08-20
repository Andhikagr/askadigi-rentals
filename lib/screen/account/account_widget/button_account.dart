import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonAccount extends StatelessWidget {
  final String label;
  final Color colors;
  final Color textColors;
  final Widget page;

  const ButtonAccount({
    super.key,
    required this.label,
    required this.colors,
    required this.page,
    required this.textColors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => page,
        transition: Transition.native,
        duration: Duration(milliseconds: 500),
      ),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              offset: Offset(1, 2),
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
              color: textColors,
            ),
          ),
        ),
      ),
    );
  }
}
