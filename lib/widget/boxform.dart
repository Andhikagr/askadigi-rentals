import 'package:car_rental/core/constant/colors.dart';
import 'package:flutter/material.dart';

class BoxForm extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final IconData iconsPick;

  const BoxForm({
    super.key,
    required this.label,
    this.controller,
    this.onTap,
    required this.readOnly,
    required this.iconsPick,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      readOnly: readOnly,
      style: TextStyle(color: outlineColor(context)),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(iconsPick, color: outlineVariantColor(context)),
        contentPadding: EdgeInsets.all(15),
        labelText: label,
        labelStyle: TextStyle(color: outlineColor(context), fontSize: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: outlineVariantColor(context),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: outlineVariantColor(context),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
