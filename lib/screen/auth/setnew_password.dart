import 'package:car_rental/widget/boxtext.dart';
import 'package:car_rental/widget/button_one.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:car_rental/screen/auth/reset_password.dart';
import 'package:car_rental/screen/auth/verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
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
            padding: EdgeInsets.all(context.shortp(0.02)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/image/unlockpass.png",
                    fit: BoxFit.cover,
                    width: context.shortp(0.28),
                  ),
                  SizedBox(height: context.shortp(0.03)),
                  Text(
                    "Set New Password",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "Enter a new password for your account",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: context.shortp(0.09)),
                  BoxText(label: "New Password", iconData: Icons.lock_open),
                  SizedBox(height: context.shortp(0.06)),
                  BoxText(label: "Repeat Password", iconData: Icons.lock_open),
                  SizedBox(height: context.shortp(0.03)),
                  Text(
                    "Password must be at least 8 characters long and include an uppercase letter and a special character.",

                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.shortp(0.08)),
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
