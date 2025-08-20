import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/screen/account/auth_page/setnew_password.dart';
import 'package:car_rental/core/widget_global/boxtext.dart';
import 'package:car_rental/core/widget_global/button_one.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _validatePhoneController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: onInverseSurfaceColor(context),
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Get.back();
          },
        ),
        backgroundColor: const Color(0xFFFF1908),
        foregroundColor: onInverseSurfaceColor(context),
        elevation: 2,
        shadowColor: onSurfaceColor(context).withValues(alpha: 0.4),
      ),
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              "Forgot Password",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.justify,
                              "Please enter your phone number to get back into your account",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 30),
                            BoxText(
                              label: "Phone Number",
                              iconData: Icons.phone,
                              textController: _validatePhoneController,
                              input: TextInputType.numberWithOptions(),
                            ),
                            SizedBox(height: 30),
                            buttonOne(context, "Confirmation", () async {
                              FocusScope.of(context).unfocus();
                              if (_validatePhoneController.text
                                  .trim()
                                  .isEmpty) {
                                Fluttertoast.showToast(
                                  msg: "Please enter your phone number",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.black87.withValues(
                                    alpha: 0.5,
                                  ),
                                  textColor: onInverseSurfaceColor(context),
                                  fontSize: 14,
                                );
                                return;
                              }
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String? savedPhone = prefs.getString(
                                "user_phone",
                              );
                              if (savedPhone !=
                                  _validatePhoneController.text.trim()) {
                                Fluttertoast.showToast(
                                  msg: "Invalid Phone Numbers",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.black87,
                                  textColor: Colors.white,
                                  fontSize: 14,
                                );
                              } else {
                                Get.to(
                                  () => SetNewPassword(),
                                  transition: Transition.native,
                                  duration: Duration(milliseconds: 300),
                                );
                              }
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
