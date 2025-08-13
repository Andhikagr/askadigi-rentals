import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/widget/button_one.dart';
import 'package:car_rental/screen/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset("assets/image/coverred.jpg", fit: BoxFit.cover),
          ),
          SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),

                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        "Password Changed",
                        style: GoogleFonts.archivoBlack(
                          fontSize: 24,
                          color: onInverseSurfaceColor(context),
                        ),
                      ),

                      Text(
                        textAlign: TextAlign.center,
                        "Your password has been changed succesfully",
                        style: TextStyle(
                          fontSize: 14,
                          color: onInverseSurfaceColor(context),
                        ),
                      ),

                      SizedBox(height: 40),
                      buttonOne(context, "Back to Login", () {
                        FocusScope.of(context).unfocus();
                        Get.off(
                          () => Login(),
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
        ],
      ),
    );
  }
}
