import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/widget/botton_three.dart';
import 'package:car_rental/widget/textform_bright.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _newPasswordcontroller = TextEditingController();
  final TextEditingController _repeatPasscontroller = TextEditingController();
  final authController = Get.find<AuthController>();

  bool oldPassword = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!authController.isLoggedIn.value) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFFF1908),
            foregroundColor: onInverseSurfaceColor(context),
            toolbarHeight: 70,
            elevation: 2,
            shadowColor: scrimColor(context),
            title: Text(
              "Login first",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        );
      } else {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: const Color(0xFFFF1908),
              foregroundColor: onInverseSurfaceColor(context),
              toolbarHeight: 70,
              elevation: 2,
              shadowColor: scrimColor(context),
              title: Text(
                "Set New Password",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Type your current password",
                          style: TextStyle(
                            color: outlineColor(context),
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormBright(
                          label: "Current Password",
                          iconData: Icons.lock,
                          controller: _passwordcontroller,
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        buttonThree(context, "verify", () async {
                          bool isCorrect = await authController
                              .verifyOldPassword(
                                _passwordcontroller.text.trim(),
                              );

                          if (isCorrect) {
                            setState(() {
                              oldPassword = true;
                            });
                          }
                        }),

                        SizedBox(height: 20),
                        Text(
                          "Password must be at least 8 characters long and include an uppercase letter and a special character.",
                          style: TextStyle(
                            color: outlineColor(context),
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 30),
                        if (oldPassword)
                          TextFormBright(
                            label: "New Password",
                            iconData: Icons.lock_open,
                            controller: _newPasswordcontroller,
                            obscureText: true,
                          ),
                        SizedBox(height: 20),
                        if (oldPassword)
                          TextFormBright(
                            label: "Repeat Password",
                            iconData: Icons.lock_open,
                            obscureText: true,
                            controller: _repeatPasscontroller,
                          ),

                        SizedBox(height: 20),
                        if (oldPassword)
                          buttonThree(context, "Reset", () async {
                            FocusScope.of(context).unfocus();

                            final newPassword = _newPasswordcontroller.text
                                .trim();
                            final repeat = _repeatPasscontroller.text.trim();
                            final capitalText = RegExp(r'[A-Z]');
                            final specialChar = RegExp(
                              r'[!@#$%^&*(),.?":{}|<>]',
                            );

                            if (newPassword.length < 8 ||
                                !capitalText.hasMatch(newPassword) ||
                                !specialChar.hasMatch(newPassword)) {
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
                            if (newPassword != repeat) {
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
                            await authController.updatePassword(newPassword);
                            Get.snackbar(
                              "Succes",
                              "Password changed",
                              colorText: Colors.grey.shade100,
                              borderRadius: 10,
                            );
                          }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}
