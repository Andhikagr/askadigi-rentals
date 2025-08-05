import 'package:car_rental/widget/button_one.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:car_rental/screen/auth/change_password.dart';
import 'package:car_rental/screen/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Get.off(
              () => ChangePassword(),
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
                    "assets/image/check.png",
                    fit: BoxFit.cover,
                    width: context.deviceWidth * 0.22,
                  ),
                  SizedBox(height: context.deviceHeight * 0.03),
                  Text(
                    "Password Changed",
                    style: GoogleFonts.archivoBlack(fontSize: 22),
                  ),

                  Text(
                    textAlign: TextAlign.center,
                    "Your password has been changed succesfully",
                    style: TextStyle(fontSize: 14),
                  ),

                  SizedBox(height: context.deviceHeight * 0.03),
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
    );
  }
}
