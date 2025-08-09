import 'dart:io';
import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:car_rental/screen/auth/login.dart';
import 'package:car_rental/screen/auth/signup.dart';
import 'package:car_rental/screen/intro/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Future<void> _pickImage() async {
    if (!await Permission.camera.request().isGranted) {
      return;
    }
    if (!await Permission.photos.request().isGranted &&
        !await Permission.mediaLibrary.request().isGranted &&
        !await Permission.storage.request().isGranted) {
      return;
    }
    //setelah izin
    final ImagePicker pickedFile = ImagePicker();
    final XFile? pick = await pickedFile.pickImage(source: ImageSource.camera);

    if (pick == null) {
      return;
    }
    setState(() {
      imageFile = File(pick.path);
    });
  }

  File? imageFile;
  String username = "";
  bool isLoggedIn = false;

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final status = prefs.getBool("isLoggedIn") ?? false;
    final name = status ? prefs.getString("username")! : "";
    setState(() {
      isLoggedIn = status;
      username = name;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> logOut() async {
    final check = await SharedPreferences.getInstance();
    await check.setBool("isLoggedIn", false);
    isLoggedIn = false;
    username = "";
    await Future.delayed(Duration(milliseconds: 300));
    Get.offAll(() => Splash());
  }

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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Account",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: onInverseSurfaceColor(context),
                            ),
                          ),
                          if (isLoggedIn)
                            IconButton(
                              icon: Image.asset(
                                "assets/image/power.png",
                                width: 40,
                              ),
                              onPressed: () {
                                logOut();
                              },
                            ),
                        ],
                      ),
                      SizedBox(height: context.shortp(0.03)),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: SizedBox(
                              height: context.shortp(0.15),
                              width: context.shortp(0.15),
                              child: ClipOval(
                                child: Image(
                                  image: imageFile != null
                                      ? FileImage(imageFile!)
                                      : AssetImage("assets/image/man.png")
                                            as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: context.shortp(0.03)),
                          Container(
                            decoration: BoxDecoration(),
                            width: context.shortp(0.72),
                            child: Padding(
                              padding: EdgeInsets.all(context.shortp(0.01)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    username,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: onInverseSurfaceColor(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      if (!isLoggedIn)
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Get.to(
                                  () => Login(),
                                  transition: Transition.native,
                                  duration: Duration(seconds: 1),
                                ),
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),

                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: onSurfaceColor(context),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),

                            Expanded(
                              child: GestureDetector(
                                onTap: () => Get.to(
                                  () => Signup(),
                                  transition: Transition.native,
                                  duration: Duration(seconds: 1),
                                ),
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.5,
                                      color: onInverseSurfaceColor(context),
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.red,
                                  ),

                                  child: Center(
                                    child: Text(
                                      "Daftar",
                                      style: TextStyle(
                                        color: onInverseSurfaceColor(context),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
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
