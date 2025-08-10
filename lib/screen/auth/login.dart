import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/mainpage.dart';
import 'package:car_rental/screen/auth/forgot_password.dart';
import 'package:car_rental/widget/button_one.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:car_rental/widget/socialbutton.dart';
import 'package:car_rental/screen/auth/signup.dart';
import 'package:car_rental/widget/textform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    final check = await SharedPreferences.getInstance();
    if (!mounted) return;
    final savedEmail = check.getString("user_email");
    final savedPassword = check.getString("user_password");

    if (_emailController.text.trim() == savedEmail &&
        _passwordController.text.trim() == savedPassword) {
      await check.setBool("isLoggedIn", true);
      if (!mounted) return;

      //update authcontroller
      final auth = Get.find<AuthController>();
      auth.isLoggedIn.value = true;

      final navigate = Get.find<NavController>();
      navigate.selectedIndex.value = 0;
      if (!mounted) return;
      Get.offAll(() => Mainpage());
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Email or password is not match")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            final navigate = Get.find<NavController>();
            navigate.selectedIndex.value = 0;
            Get.off(() => Mainpage());
          },
          icon: Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFF1908),
        foregroundColor: onInverseSurfaceColor(context),
        elevation: 2,
        shadowColor: onSurfaceColor(context).withValues(alpha: 0.4),
        title: Text("Log In"),
      ),
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
                                  "Log in to your account using email or social networks.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: onInverseSurfaceColor(context),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Textform(
                                  label: "Email",
                                  iconData: Icons.email,
                                  controller: _emailController,
                                ),
                                SizedBox(height: 20),
                                Textform(
                                  label: "Password",
                                  iconData: Icons.lock,
                                  controller: _passwordController,
                                  obscureText: true,
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      Get.to(
                                        () => ForgotPassword(),
                                        transition: Transition.native,
                                        duration: Duration(milliseconds: 1000),
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
                                buttonOne(context, "Log in", () async {
                                  FocusScope.of(context).unfocus();
                                  login();
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                  Center(
                    child: Container(
                      height: 60,
                      width: 300,
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
                              Get.off(
                                () => Signup(),
                                transition: Transition.leftToRight,
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
                        "assets/image/whatsapp.png",
                        "Whatsapp",
                      ),
                    ],
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
