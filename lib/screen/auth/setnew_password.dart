import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/screen/auth/forgot_password.dart';
import 'package:car_rental/widget/button_one.dart';

import 'package:car_rental/screen/auth/reset_password.dart';
import 'package:car_rental/widget/textform.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _repeatPasscontroller = TextEditingController();
  final authController = Get.find<AuthController>();

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
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: onInverseSurfaceColor(context),
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Get.off(
                              () => ForgotPassword(),
                              transition: Transition.native,
                              duration: Duration(milliseconds: 1000),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 10),
                      Text(
                        "Set New Password",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: onInverseSurfaceColor(context),
                        ),
                      ),
                      Text(
                        "Password must be at least 8 characters long and include an uppercase letter and a special character.",
                        style: TextStyle(
                          color: onInverseSurfaceColor(context),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 30),
                      TextForm(
                        label: "New Password",
                        iconData: Icons.lock_open,
                        controller: _passwordcontroller,
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      TextForm(
                        label: "Repeat Password",
                        iconData: Icons.lock_open,
                        obscureText: true,
                        controller: _repeatPasscontroller,
                      ),

                      SizedBox(height: 40),
                      buttonOne(context, "Reset Password", () async {
                        FocusScope.of(context).unfocus();

                        final password = _passwordcontroller.text.trim();
                        final repeat = _repeatPasscontroller.text.trim();
                        final capitalText = RegExp(r'[A-Z]');
                        final specialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

                        if (password.length < 8 ||
                            !capitalText.hasMatch(password) ||
                            !specialChar.hasMatch(password)) {
                          Fluttertoast.showToast(
                            msg: "Invalid password format",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: onInverseSurfaceColor(context),
                            textColor: onSurfaceColor(context),
                            fontSize: 14,
                          );
                          return;
                        }
                        if (password != repeat) {
                          Fluttertoast.showToast(
                            msg: "Password not match",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: onInverseSurfaceColor(context),
                            textColor: onSurfaceColor(context),
                            fontSize: 14,
                          );
                          return;
                        }
                        await authController.updatePassword(password);
                        Get.off(
                          () => ResetPassword(),
                          transition: Transition.native,
                          duration: Duration(milliseconds: 500),
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
