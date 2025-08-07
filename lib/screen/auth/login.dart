import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/mainpage.dart';
import 'package:car_rental/screen/auth/forgot_password.dart';
import 'package:car_rental/widget/boxtext.dart';
import 'package:car_rental/widget/button_one.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:car_rental/widget/socialbutton.dart';
import 'package:car_rental/screen/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.shortp(0.04),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.shortp(0.08)),
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 26,
                          color: onInverseSurfaceColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Log in to your account using email or social networks.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: onInverseSurfaceColor(context),
                        ),
                      ),
                      SizedBox(height: context.shortp(0.05)),
                      BoxText(label: "Email", iconData: Icons.email),
                      SizedBox(height: context.shortp(0.06)),
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
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.shortp(0.03),
                            ),
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 14,
                                color: onInverseSurfaceColor(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: context.shortp(0.06)),
                      buttonOne(context, "Log in", () {
                        FocusScope.of(context).unfocus();
                        Get.off(
                          () => Mainpage(),
                          transition: Transition.native,
                          duration: Duration(milliseconds: 300),
                        );
                      }),
                      SizedBox(height: context.shortp(0.75)),
                      Center(
                        child: Container(
                          height: context.shortp(0.09),
                          width: context.shortp(0.75),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: onInverseSurfaceColor(context),
                          ),
                          child: Row(
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
                                  "Sign Up,",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                " or sign in with",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: context.shortp(0.04)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          socialButton(
                            context,
                            "assets/image/googlewhite.png",
                            "Google",
                          ),
                          SizedBox(width: context.shortp(0.05)),
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
        ],
      ),
    );
  }
}
