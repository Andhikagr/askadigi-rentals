import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/core/utils/mainpage.dart';
import 'package:car_rental/screen/account/auth_page/forgot_password.dart';
import 'package:car_rental/core/widget_global/button_one.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:car_rental/screen/account/auth_page/signup.dart';
import 'package:car_rental/core/widget_global/textform.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final authController = Get.find<AuthController>();

  //validasi login
  void login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Email, and Password must not be empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black87.withValues(alpha: 0.5),
        textColor: onInverseSurfaceColor(context),
        fontSize: 14,
      );
      return;
    }
    bool succes = await authController.login(email, password);
    if (!mounted) return;
    if (!succes) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Invalid email or password")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            final navigate = Get.find<NavController>();
            navigate.selectedIndex.value = 3;
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
          //section 1
          LayoutBuilder(
            builder: (context, constraints) {
              return SafeArea(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Padding(
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
                                  TextForm(
                                    label: "Email",
                                    iconData: Icons.email,
                                    controller: _emailController,
                                  ),
                                  SizedBox(height: 20),
                                  TextForm(
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
                                          transition: Transition.rightToLeft,
                                          duration: Duration(milliseconds: 500),
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
                                            color: onInverseSurfaceColor(
                                              context,
                                            ),
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
                            //section 2
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(padding: EdgeInsets.all(20)),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                transition:
                                                    Transition.rightToLeft,
                                                duration: Duration(
                                                  milliseconds: 500,
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Sign Up",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: const Color(0xFFFF1908),
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
                                    SizedBox(height: context.shortp(0.04)),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: Container(
                                        width: 180,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          color: onInverseSurfaceColor(context),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color: outlineVariantColor(context),
                                            width: 2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.2,
                                              ),
                                              offset: Offset(1, 2),
                                              blurRadius: 0,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/image/googlewhite.png",
                                              fit: BoxFit.cover,
                                              width: 35,
                                            ),
                                            SizedBox(
                                              width: context.longp(0.015),
                                            ),
                                            Text(
                                              "Google",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: onSurfaceColor(context),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
