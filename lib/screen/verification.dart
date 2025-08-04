import 'package:car_rental/help/button_one.dart';
import 'package:car_rental/help/colors.dart';
import 'package:car_rental/help/help.dart';
import 'package:car_rental/screen/change_password.dart';
import 'package:car_rental/screen/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Get.off(
              () => ForgotPassword(),
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
            child: Column(
              children: [
                Image.asset(
                  "assets/image/email.png",
                  fit: BoxFit.cover,
                  width: context.deviceWidth * 0.20,
                ),
                SizedBox(height: context.deviceHeight * 0.03),
                Text(
                  "Enter Verification Code",
                  style: GoogleFonts.archivoBlack(fontSize: 22),
                ),

                Text(
                  textAlign: TextAlign.center,
                  "We have sent the code verification to your Email Address",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: context.deviceHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: BoxVerify(label: "1")),
                    SizedBox(width: context.deviceWidth * 0.04),
                    Expanded(child: BoxVerify(label: "2")),
                    SizedBox(width: context.deviceWidth * 0.04),
                    Expanded(child: BoxVerify(label: "3")),
                    SizedBox(width: context.deviceWidth * 0.04),
                    Expanded(child: BoxVerify(label: "4")),
                  ],
                ),

                SizedBox(height: context.deviceHeight * 0.03),
                buttonOne(context, "Verify", () {
                  FocusScope.of(context).unfocus();
                  Get.to(
                    () => ChangePassword(),
                    transition: Transition.native,
                    duration: Duration(milliseconds: 300),
                  );
                }),
                SizedBox(height: context.deviceHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "Didn’t receive the code?",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(width: context.deviceWidth * 0.02),
                    Text(
                      textAlign: TextAlign.center,
                      "Resend",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: onPrimaryContainerColor(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BoxVerify extends StatelessWidget {
  final String label;

  const BoxVerify({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.deviceHeight * 0.08,
      decoration: BoxDecoration(
        color: primaryContainerColor(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(context.deviceWidth * 0.02),
        child: Center(child: Text(label)),
      ),
    );
  }
}
