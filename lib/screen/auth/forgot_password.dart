import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/widget/boxtext.dart';
import 'package:car_rental/widget/button_one.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:car_rental/screen/auth/login.dart';
import 'package:car_rental/screen/auth/verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                padding: EdgeInsets.symmetric(horizontal: context.shortp(0.04)),
                child: Column(
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
                            () => Login(),
                            transition: Transition.native,
                            duration: Duration(milliseconds: 300),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: context.deviceHeight * 0.01),
                            Text(
                              "Forgot Password",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.justify,
                              "Please enter your email address. So we'll send you link to get back into your account",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: context.shortp(0.09)),
                            BoxText(
                              label: "Email",
                              iconData: Icons.email_outlined,
                            ),
                            SizedBox(height: context.shortp(0.08)),
                            buttonOne(context, "Send Code", () {
                              FocusScope.of(context).unfocus();
                              Get.to(
                                () => Verification(),
                                transition: Transition.native,
                                duration: Duration(milliseconds: 300),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
