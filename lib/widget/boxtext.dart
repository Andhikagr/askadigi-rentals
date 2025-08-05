import 'package:car_rental/core/constant/colors.dart';
import 'package:flutter/material.dart';

class BoxText extends StatelessWidget {
  final String label;
  final IconData iconData;

  const BoxText({super.key, required this.label, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: inverseSurfaceColor(context).withValues(alpha: 0.15),
            blurRadius: 6,
            spreadRadius: 1,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: TextFormField(
        enableSuggestions: false,
        cursorColor: outlineColor(context),
        style: TextStyle(color: outlineColor(context)),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: Icon(iconData, color: outlineColor(context)),
          labelText: label,
          labelStyle: TextStyle(fontSize: 14, color: outlineColor(context)),
          filled: true,
          fillColor: surfContainerColor(context),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
