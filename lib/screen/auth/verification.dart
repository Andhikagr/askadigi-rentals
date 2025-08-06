import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/widget/button_one.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:car_rental/screen/auth/setnew_password.dart';
import 'package:car_rental/screen/auth/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              () => ForgotPassword(),
                              transition: Transition.native,
                              duration: Duration(milliseconds: 300),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: context.shortp(0.01)),
                      Text(
                        "Enter Verification Code",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: onInverseSurfaceColor(context),
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.justify,
                        "We have sent the code verification to your Email Address",
                        style: TextStyle(
                          fontSize: 14,
                          color: onInverseSurfaceColor(context),
                        ),
                      ),
                      SizedBox(height: context.shortp(0.06)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(child: BoxVerify(label: "1")),
                          SizedBox(width: context.shortp(0.005)),
                          SizedBox(child: BoxVerify(label: "2")),
                          SizedBox(width: context.shortp(0.005)),
                          SizedBox(child: BoxVerify(label: "3")),
                          SizedBox(width: context.shortp(0.005)),
                          SizedBox(child: BoxVerify(label: "4")),
                        ],
                      ),

                      SizedBox(height: context.shortp(0.06)),
                      buttonOne(context, "Verify", () {
                        FocusScope.of(context).unfocus();
                        Get.to(
                          () => SetNewPassword(),
                          transition: Transition.native,
                          duration: Duration(milliseconds: 300),
                        );
                      }),
                      SizedBox(height: context.shortp(0.04)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: context.shortp(0.09),
                            width: context.shortp(0.65),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: onInverseSurfaceColor(context),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  "Didn’t receive the code?",
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(width: context.shortp(0.01)),
                                Text(
                                  textAlign: TextAlign.center,
                                  "Resend",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
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

class BoxVerify extends StatelessWidget {
  final String label;

  const BoxVerify({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.shortp(0.02)),
      width: context.shortp(0.18),
      height: context.shortp(0.18),
      decoration: BoxDecoration(
        color: onInverseSurfaceColor(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(context.shortp(0.02)),
        child: Center(child: Text(label)),
      ),
    );
  }
}
