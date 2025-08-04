import 'package:flutter/material.dart';

class BoxText extends StatelessWidget {
  final String label;
  final IconData iconData;

  const BoxText({super.key, required this.label, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: false,
      cursorColor: Colors.grey.shade600,
      style: TextStyle(color: Colors.grey.shade600),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: Icon(iconData, color: Colors.grey.shade600),
        labelText: label,
        labelStyle: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        filled: true,
        fillColor: Colors.grey.shade200,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
