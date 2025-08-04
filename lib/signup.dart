import 'package:car_rental/help/boxtext.dart';
import 'package:car_rental/help/help.dart';
import 'package:car_rental/help/socialbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                    Text(
                      "Create New Account",
                      style: GoogleFonts.archivoBlack(
                        fontSize: 22,

                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.center,
                      "Set up your username and password.\nYou can always change it later.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 30),
                    BoxText(label: "Username", iconData: Icons.account_circle),
                    SizedBox(height: 30),
                    BoxText(label: "Email", iconData: Icons.email),
                    SizedBox(height: 30),
                    BoxText(label: "Password", iconData: Icons.lock),
                    SizedBox(height: 30),
                    BoxText(label: "Repeat Password", iconData: Icons.password),

                    SizedBox(height: 30),
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
                              "Sign up",
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
                          "Alreade have an account? ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            "Login",
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
                          "Facebook",
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
