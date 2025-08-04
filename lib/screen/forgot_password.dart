import 'package:car_rental/help/boxtext.dart';
import 'package:car_rental/help/button_one.dart';
import 'package:car_rental/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            FocusScope.of(context).unfocus();
            Get.off(
              () => Login(),
              transition: Transition.native,
              duration: Duration(milliseconds: 500),
            );
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
                    "Forgot Password",
                    style: GoogleFonts.archivoBlack(
                      fontSize: 22,

                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    textAlign: TextAlign.center,
                    "Please enter your email address. So we'll send you link to get back into your account",
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
