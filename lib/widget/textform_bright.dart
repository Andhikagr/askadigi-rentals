import 'package:car_rental/core/constant/colors.dart';
import 'package:flutter/material.dart';

class TextFormBright extends StatefulWidget {
  final String label;
  final IconData iconData;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;

  const TextFormBright({
    super.key,
    required this.label,
    required this.iconData,
    this.controller,

    this.obscureText = false,
    this.keyboardType,
  });

  @override
  State<TextFormBright> createState() => _BoxTextState();
}

class _BoxTextState extends State<TextFormBright> {
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          controller: widget.controller,
          obscureText: obscure,
          keyboardType: widget.keyboardType,
          enableSuggestions: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            floatingLabelBehavior: FloatingLabelBehavior.always,
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
            fillColor: surfaceColor(context),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: outlineVariantColor(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: outlineVariantColor(context)),
            ),
          ),
        ),
      ),
    );
  }
}
