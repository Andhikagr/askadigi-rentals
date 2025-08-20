import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/screen/account/auth_page/login.dart';
import 'package:car_rental/core/widget_global/button_one.dart';
import 'package:car_rental/screen/account/auth_page/reset_password.dart';
import 'package:car_rental/core/widget_global/textform.dart';
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
                      //validasi password
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
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => Get.off(
                          () => Login(),
                          transition: Transition.upToDown,
                          duration: Duration(milliseconds: 1000),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: 130,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Back to Login",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
