import 'package:car_rental/help/boxtext.dart';
import 'package:car_rental/help/button_one.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Create New Account",
                    style: GoogleFonts.archivoBlack(
                      fontSize: 22,

                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    textAlign: TextAlign.center,
                    "Set up your username and password.\nYou can always change it later.",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
                  ),
                  SizedBox(height: 30),
                  BoxText(label: "Email", iconData: Icons.email_outlined),
                  SizedBox(height: 30),
                  buttonOne(context, "Send Code", () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
