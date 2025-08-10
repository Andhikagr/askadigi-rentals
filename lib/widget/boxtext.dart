import 'package:car_rental/core/constant/colors.dart';
import 'package:flutter/material.dart';

class BoxText extends StatelessWidget {
  final String label;
  final IconData iconData;

  const BoxText({super.key, required this.label, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          enableSuggestions: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(iconData, color: outlineVariantColor(context)),
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 14,
              color: outlineVariantColor(context),
            ),
            filled: true,
            fillColor: onInverseSurfaceColor(context),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
