import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/core/utils/mainpage.dart';
import 'package:car_rental/core/widget_global/button_one.dart';
import 'package:car_rental/screen/account/auth_page/login.dart';
import 'package:car_rental/core/widget_global/textform.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();

  final authController = Get.find<AuthController>();

  void signUp() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();
    final repPass = _repeatController.text.trim();
    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        repPass.isEmpty) {
      Fluttertoast.showToast(
        msg: "All field must be filled",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.black87.withValues(alpha: 0.5),
        textColor: onInverseSurfaceColor(context),
        fontSize: 14,
      );

      return;
    }
    if (password != repPass) {
      Fluttertoast.showToast(
        msg: "Password not match",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.black87.withValues(alpha: 0.5),
        textColor: onInverseSurfaceColor(context),
        fontSize: 14,
      );
      return;
    }

    authController.signUp(name, email, phone, password);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _repeatController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            final navigate = Get.find<NavController>();
            navigate.selectedIndex.value = 3;
            Get.offAll(() => Mainpage());
          },
          icon: Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFF1908),
        foregroundColor: onInverseSurfaceColor(context),
        elevation: 2,
        shadowColor: onSurfaceColor(context).withValues(alpha: 0.4),
        title: Text("Sign Up"),
      ),
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
                                  "Set up your username and password. You can always change it later.",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: onInverseSurfaceColor(context),
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextForm(
                                  label: "Username",
                                  iconData: Icons.account_circle,
                                  controller: _nameController,
                                ),
                                SizedBox(height: 20),
                                TextForm(
                                  label: "Email",
                                  iconData: Icons.email,
                                  controller: _emailController,
                                ),
                                SizedBox(height: 20),
                                TextForm(
                                  label: "Phone Numbers",
                                  iconData: Icons.phone,
                                  controller: _phoneController,
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                ),
                                SizedBox(height: 20),
                                TextForm(
                                  label: "Password",
                                  iconData: Icons.lock,
                                  controller: _passwordController,
                                  obscureText: true,
                                ),
                                SizedBox(height: 20),
                                TextForm(
                                  label: "Repeat Password",
                                  iconData: Icons.password,
                                  controller: _repeatController,
                                  obscureText: true,
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
                    child: buttonOne(context, "Sign Up", signUp),
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
                              transition: Transition.rightToLeft,
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
