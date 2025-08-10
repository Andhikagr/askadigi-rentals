import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/mainpage.dart';
import 'package:car_rental/widget/button_one.dart';
import 'package:car_rental/screen/auth/login.dart';
import 'package:car_rental/widget/textform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _repeatcontroller = TextEditingController();

  void signUp() async {
    final name = _namecontroller.text.trim();
    final email = _emailcontroller.text.trim();
    final phone = _phonecontroller.text.trim();
    final password = _passwordcontroller.text.trim();
    final repPassword = _repeatcontroller.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        repPassword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("All field must be filled")));
      return;
    }
    if (password != repPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Password Not Match")));
      return;
    }

    final check = await SharedPreferences.getInstance();
    if (!mounted) return;
    await check.setString("username", name);
    await check.setString("user_email", email);
    await check.setString("phone_number", phone);
    await check.setString("user_password", password);
    await check.setBool("isLoggedIn", true);

    final navigate = Get.find<NavController>();
    navigate.selectedIndex.value = 0;

    Get.offAll(() => Mainpage());
  }

  @override
  void dispose() {
    super.dispose();
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _phonecontroller.dispose();
    _passwordcontroller.dispose();
    _repeatcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                                Textform(
                                  label: "Username",
                                  iconData: Icons.account_circle,
                                  controller: _namecontroller,
                                ),
                                SizedBox(height: 20),
                                Textform(
                                  label: "Email",
                                  iconData: Icons.email,
                                  controller: _emailcontroller,
                                ),
                                SizedBox(height: 20),
                                Textform(
                                  label: "Phone Numbers",
                                  iconData: Icons.phone,
                                  controller: _phonecontroller,
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                ),
                                SizedBox(height: 20),
                                Textform(
                                  label: "Password",
                                  iconData: Icons.lock,
                                  controller: _passwordcontroller,
                                  obscureText: true,
                                ),
                                SizedBox(height: 20),
                                Textform(
                                  label: "Repeat Password",
                                  iconData: Icons.password,
                                  controller: _repeatcontroller,
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
