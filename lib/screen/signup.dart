import 'package:car_rental/help/boxtext.dart';
import 'package:car_rental/help/button_one.dart';
import 'package:car_rental/help/colors.dart';
import 'package:car_rental/help/socialbutton.dart';
import 'package:car_rental/screen/login.dart';
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
                      style: GoogleFonts.archivoBlack(fontSize: 22),
                    ),
                    SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.center,
                      "Set up your username and password.\nYou can always change it later.",
                      style: TextStyle(fontSize: 14),
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
                    buttonOne(context, "Sign Up", () {}),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Alreade have an account? ",
                          style: TextStyle(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.off(
                              () => Login(),
                              transition: Transition.native,
                              duration: Duration(milliseconds: 500),
                            );
                          },
                          child: Text(
                            "Login",
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
