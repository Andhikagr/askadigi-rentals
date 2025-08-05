import 'package:car_rental/widget/boxtext.dart';
import 'package:car_rental/widget/button_one.dart';
import 'package:car_rental/core/utils/help.dart';
import 'package:car_rental/screen/auth/reset_password.dart';
import 'package:car_rental/screen/auth/verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Get.off(
              () => Verification(),
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
                    "assets/image/reset.png",
                    fit: BoxFit.cover,
                    width: context.deviceWidth * 0.22,
                  ),
                  SizedBox(height: context.deviceHeight * 0.03),
                  Text(
                    "Set New Password",
                    style: GoogleFonts.archivoBlack(fontSize: 22),
                  ),

                  Text(
                    textAlign: TextAlign.center,
                    "Enter a new password for your account",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: context.deviceHeight * 0.03),
                  BoxText(label: "New Password", iconData: Icons.lock_open),
                  SizedBox(height: context.deviceHeight * 0.03),
                  BoxText(label: "Repeat Password", iconData: Icons.lock_open),
                  SizedBox(height: context.deviceHeight * 0.03),
                  Text(
                    "Password must be at least 8 characters long and include an uppercase letter and a special character.",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.deviceHeight * 0.03),
                  buttonOne(context, "Reset Password", () {
                    FocusScope.of(context).unfocus();
                    Get.to(
                      () => ResetPassword(),
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
