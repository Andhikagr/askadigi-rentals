import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/widget/boxtext.dart';
import 'package:car_rental/widget/button_one.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:car_rental/screen/auth/reset_password.dart';
import 'package:car_rental/screen/auth/verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
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
                              () => Verification(),
                              transition: Transition.native,
                              duration: Duration(milliseconds: 1000),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: context.shortp(0.01)),
                      Text(
                        "Set New Password",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: onInverseSurfaceColor(context),
                        ),
                      ),
                      Text(
                        "Password must be at least 8 characters long and include an uppercase letter and a special character.",
                        style: TextStyle(color: onInverseSurfaceColor(context)),
                        textAlign: TextAlign.justify,
                      ),

                      SizedBox(height: context.shortp(0.06)),

                      BoxText(label: "New Password", iconData: Icons.lock_open),
                      SizedBox(height: context.shortp(0.06)),
                      BoxText(
                        label: "Repeat Password",
                        iconData: Icons.lock_open,
                      ),

                      SizedBox(height: context.shortp(0.06)),
                      buttonOne(context, "Reset Password", () {
                        FocusScope.of(context).unfocus();
                        Get.to(
                          () => ResetPassword(),
                          transition: Transition.native,
                          duration: Duration(milliseconds: 300),
                        );
                      }),
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
