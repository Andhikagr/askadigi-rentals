import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/widget/boxtext.dart';
import 'package:car_rental/widget/button_one.dart';
import 'package:car_rental/screen/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
          LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Expanded(
                    child: SafeArea(
                      child: GestureDetector(
                        onTap: () => FocusScope.of(context).unfocus(),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  "Create New Account",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: onInverseSurfaceColor(context),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Set up your username and password. You can always change it later.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: onInverseSurfaceColor(context),
                                  ),
                                ),
                                SizedBox(height: 20),
                                BoxText(
                                  label: "Username",
                                  iconData: Icons.account_circle,
                                ),
                                SizedBox(height: 20),
                                BoxText(label: "Email", iconData: Icons.email),
                                SizedBox(height: 20),
                                BoxText(
                                  label: "Password",
                                  iconData: Icons.lock,
                                ),
                                SizedBox(height: 20),
                                BoxText(
                                  label: "Repeat Password",
                                  iconData: Icons.password,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: buttonOne(context, "Sign Up", () {}),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Alreade have an account? ",
                          style: TextStyle(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Get.off(
                              () => Login(),
                              transition: Transition.native,
                              duration: Duration(milliseconds: 300),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
