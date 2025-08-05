import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/homepage.dart/dashboard.dart';
import 'package:car_rental/screen/auth/forgot_password.dart';
import 'package:car_rental/widget/boxtext.dart';
import 'package:car_rental/widget/button_one.dart';
import 'package:car_rental/core/utils/help.dart';
import 'package:car_rental/widget/socialbutton.dart';
import 'package:car_rental/screen/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/image/logo.png",
                      height: context.deviceHeight * 0.1,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Welcome Back",
                      style: GoogleFonts.archivoBlack(fontSize: 22),
                    ),
                    Text(
                      "Log in to your account using email or social networks",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 30),
                    BoxText(label: "Email", iconData: Icons.email),
                    SizedBox(height: 30),
                    BoxText(label: "Password", iconData: Icons.lock),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          Get.to(
                            () => ForgotPassword(),
                            transition: Transition.native,
                            duration: Duration(milliseconds: 300),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor(context),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),
                    buttonOne(context, "Log in", () {
                      FocusScope.of(context).unfocus();
                      Get.to(
                        () => Dashboard(),
                        transition: Transition.native,
                        duration: Duration(milliseconds: 300),
                      );
                    }),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "First time here? ",
                          style: TextStyle(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Get.to(
                              () => Signup(),
                              transition: Transition.native,
                              duration: Duration(milliseconds: 300),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Text("or sign in with", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        socialButton(
                          context,
                          "assets/image/google.png",
                          "Google",
                        ),
                        socialButton(
                          context,
                          "assets/image/facebook.png",
                          "facebook",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
