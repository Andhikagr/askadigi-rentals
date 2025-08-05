import 'package:car_rental/widget/boxtext.dart';
import 'package:car_rental/widget/button_one.dart';
import 'package:car_rental/core/utils/help.dart';
import 'package:car_rental/screen/auth/login.dart';
import 'package:car_rental/screen/auth/verification.dart';
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
              duration: Duration(milliseconds: 300),
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
                  Image.asset(
                    "assets/image/forgotpass.png",
                    fit: BoxFit.cover,
                    width: context.deviceWidth * 0.25,
                  ),
                  SizedBox(height: context.deviceHeight * 0.03),
                  Text(
                    "Forgot Password",
                    style: GoogleFonts.archivoBlack(fontSize: 22),
                  ),

                  Text(
                    textAlign: TextAlign.center,
                    "Please enter your email address. So we'll send you link to get back into your account",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: context.deviceHeight * 0.03),
                  BoxText(label: "Email", iconData: Icons.email_outlined),
                  SizedBox(height: context.deviceHeight * 0.03),
                  buttonOne(context, "Send Code", () {
                    FocusScope.of(context).unfocus();
                    Get.to(
                      () => Verification(),
                      transition: Transition.native,
                      duration: Duration(milliseconds: 300),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
