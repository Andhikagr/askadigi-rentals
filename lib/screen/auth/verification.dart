import 'package:car_rental/widget/button_one.dart';
import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:car_rental/screen/auth/setnew_password.dart';
import 'package:car_rental/screen/auth/forgot_password.dart';
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
        backgroundColor: Colors.transparent,
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
            padding: EdgeInsets.all(context.shortp(0.02)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/image/gmail.png",
                    fit: BoxFit.cover,
                    width: context.shortp(0.25),
                  ),
                  SizedBox(height: context.shortp(0.03)),
                  Text(
                    "Enter Verification Code",
                    style: GoogleFonts.archivoBlack(fontSize: 22),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "We have sent the code verification to your Email Address",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: context.shortp(0.09)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(child: BoxVerify(label: "1")),
                      SizedBox(width: context.shortp(0.010)),
                      SizedBox(child: BoxVerify(label: "2")),
                      SizedBox(width: context.shortp(0.010)),
                      SizedBox(child: BoxVerify(label: "3")),
                      SizedBox(width: context.shortp(0.010)),
                      SizedBox(child: BoxVerify(label: "4")),
                    ],
                  ),

                  SizedBox(height: context.shortp(0.04)),
                  buttonOne(context, "Verify", () {
                    FocusScope.of(context).unfocus();
                    Get.to(
                      () => SetNewPassword(),
                      transition: Transition.native,
                      duration: Duration(milliseconds: 300),
                    );
                  }),
                  SizedBox(height: context.shortp(0.04)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "Didn’t receive the code?",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(width: context.shortp(0.02)),
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
      margin: EdgeInsets.symmetric(horizontal: context.shortp(0.025)),
      width: context.shortp(0.18),
      height: context.shortp(0.18),
      decoration: BoxDecoration(
        color: surfContainerColor(context),
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
      child: Padding(
        padding: EdgeInsets.all(context.shortp(0.02)),
        child: Center(child: Text(label)),
      ),
    );
  }
}
