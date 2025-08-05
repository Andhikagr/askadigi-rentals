import 'package:car_rental/core/utils/size_helper.dart';
import 'package:car_rental/screen/home/dashboard.dart';
import 'package:car_rental/screen/auth/forgot_password.dart';
import 'package:car_rental/widget/boxtext.dart';
import 'package:car_rental/widget/button_one.dart';
import 'package:car_rental/core/utils/media_query.dart';
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
            padding: EdgeInsets.all(context.shortp(0.02)),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/image/logoaskadigi.png",
                      width: context.shortp(0.4),
                    ),
                    Text(
                      "Welcome Back",
                      style: GoogleFonts.archivoBlack(fontSize: 22),
                    ),
                    Text(
                      "Log in to your account using email or social networks",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: context.shortp(0.08)),
                    BoxText(label: "Email", iconData: Icons.email),
                    SizedBox(height: context.shortp(0.02)),
                    BoxText(label: "Password", iconData: Icons.lock),
                    SizedBox(height: context.shortp(0.03)),
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
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(height: context.shortp(0.06)),
                    buttonOne(context, "Log in", () {
                      FocusScope.of(context).unfocus();
                      Get.to(
                        () => Dashboard(),
                        transition: Transition.native,
                        duration: Duration(milliseconds: 300),
                      );
                    }),
                    SizedBox(height: context.shortp(0.06)),
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
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.shortp(0.04)),
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
