import 'package:car_rental/core/constant/colors.dart';
import 'package:flutter/material.dart';

class Textform extends StatefulWidget {
  final String label;
  final IconData iconData;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;

  const Textform({
    super.key,
    required this.label,
    required this.iconData,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  State<Textform> createState() => _BoxTextState();
}

class _BoxTextState extends State<Textform> {
  late bool obscure;

  @override
  void initState() {
    super.initState();
    obscure = widget.obscureText;
  }

  void toggleObscure() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: TextFormField(
          controller: widget.controller,
          obscureText: obscure,
          keyboardType: widget.keyboardType,
          enableSuggestions: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(
              widget.iconData,
              color: outlineVariantColor(context),
            ),
            suffixIcon: widget.obscureText
                ? Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: toggleObscure,
                      icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                        color: outlineVariantColor(context),
                      ),
                    ),
                  )
                : null,
            labelText: widget.label,
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
