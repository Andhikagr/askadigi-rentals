import 'package:car_rental/widget/button_one.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:car_rental/screen/auth/setnew_password.dart';
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
              () => SetNewPassword(),
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
                    "assets/image/check.png",
                    fit: BoxFit.cover,
                    width: context.shortp(0.23),
                  ),
                  SizedBox(height: context.shortp(0.03)),
                  Text(
                    "Password Changed",
                    style: GoogleFonts.archivoBlack(fontSize: 22),
                  ),

                  Text(
                    textAlign: TextAlign.center,
                    "Your password has been changed succesfully",
                    style: TextStyle(fontSize: 14),
                  ),

                  SizedBox(height: context.shortp(0.09)),
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
