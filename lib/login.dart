import 'package:car_rental/forgot_password.dart';
import 'package:car_rental/help/boxtext.dart';
import 'package:car_rental/help/help.dart';
import 'package:car_rental/help/socialbutton.dart';
import 'package:car_rental/signup.dart';
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
                      style: GoogleFonts.archivoBlack(
                        fontSize: 22,

                        color: Colors.grey.shade800,
                      ),
                    ),
                    Text(
                      "Log in to your account using email or social networks",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 30),
                    BoxText(label: "Email", iconData: Icons.email),
                    SizedBox(height: 30),
                    BoxText(label: "Password", iconData: Icons.lock),
                    SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => Get.to(
                          () => ForgotPassword(),
                          transition: Transition.native,
                          duration: Duration(milliseconds: 600),
                        ),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color(0xFF1382DC),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        splashColor: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(30),
                        child: Ink(
                          width: double.infinity,
                          height: context.deviceHeight * 0.065,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1382DC),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade100,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "First time here? ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => Signup(),
                              transition: Transition.native,
                              duration: Duration(milliseconds: 600),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(0xFF166CB2),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Text(
                      "or sign in with",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade800,
                      ),
                    ),
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
