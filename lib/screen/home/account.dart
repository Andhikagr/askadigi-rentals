import 'dart:io';
import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/order_controller.dart';

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
  Future<void> _pickImage(GlobalKey key) async {
    final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);

    final source = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + box.size.height,
        position.dy + box.size.width,
        position.dy,
      ),
      color: Colors.grey.shade200,
      items: [
        PopupMenuItem(
          value: ImageSource.camera,
          child: SizedBox(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 10),
                Text("camera"),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          value: ImageSource.gallery,
          child: SizedBox(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.photo_library),
                SizedBox(width: 10),
                Text("gallery"),
              ],
            ),
          ),
        ),
      ],
    );

    if (source == null) return;

    if (source == ImageSource.camera) {
      if (!await Permission.camera.request().isGranted) {
        return;
      }
    } else if (source == ImageSource.gallery) {
      if (!await Permission.photos.request().isGranted &&
          !await Permission.mediaLibrary.request().isGranted &&
          !await Permission.storage.request().isGranted) {
        return;
      }
    }

    final ImagePicker picker = ImagePicker();
    final XFile? pick = await picker.pickImage(source: source);

    if (pick != null) {
      setState(() {
        imageFile = File(pick.path);
      });
      return;
    }
  }

  File? imageFile;
  String username = "";
  String useremail = "";
  bool isLoggedIn = false;

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final status = prefs.getBool("isLoggedIn") ?? false;
    final name = status ? prefs.getString("username")! : "";
    final email = status ? prefs.getString("user_email")! : "";
    setState(() {
      isLoggedIn = status;
      username = name;
      useremail = email;
    });
  }

  final _picked = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> logOut() async {
    final check = await SharedPreferences.getInstance();
    await check.setBool("isLoggedIn", false);
    final orderController = Get.find<OrderController>();
    String email = orderController.userEmail.value;
    if (email.isNotEmpty) {
      await check.remove("order_${email}_selectedCars");
      await check.remove("order_${email}_pickedDate");
      await check.remove("order_${email}_returnDate");
      await check.remove("order_${email}_totalPrice");
    }

    // Reset state controller
    orderController.userEmail.value = '';
    orderController.clearCars();

    // Reset login state di aplikasi
    isLoggedIn = false;
    username = "";
    useremail = "";

    await Future.delayed(Duration(milliseconds: 300));
    Get.offAll(() => Splash());
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menu = [
      {"title": "Setting", "icon": Icons.settings},
      {"title": "Address", "icon": Icons.place},
      {"title": "Change Password", "icon": Icons.lock},
      {"title": "Help & Support", "icon": Icons.help},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF1908),
        foregroundColor: onInverseSurfaceColor(context),
        automaticallyImplyLeading: false,
        title: Text(
          "Profile Account",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        actions: [
          if (isLoggedIn)
            IconButton(
              icon: Image.asset("assets/image/power.png", width: 40),
              onPressed: () {
                logOut();
              },
            ),
        ],
        toolbarHeight: 70,
        elevation: 2,
        shadowColor: scrimColor(context),
      ),

      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.shortp(0.04)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: context.shortp(0.03)),
                Row(
                  children: [
                    GestureDetector(
                      key: _picked,
                      onTap: () => _pickImage(_picked),
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
                    SizedBox(
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
                                color: onSurfaceColor(context),
                              ),
                            ),
                            Text(
                              useremail,
                              style: TextStyle(
                                fontSize: 16,
                                color: outlineColor(context),
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
                            duration: Duration(milliseconds: 500),
                          ),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Color(0xFFFF1908),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFFF1908),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  offset: Offset(1, 2),
                                  blurRadius: 1,
                                ),
                              ],
                            ),

                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: onInverseSurfaceColor(context),
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
                            duration: Duration(milliseconds: 500),
                          ),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFFF1908),
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Daftar",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: onSurfaceColor(context),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 40),
                Divider(
                  color: outlineVariantColor(context), // warna garis
                  thickness: 1, // ketebalan garis
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        height: constraints.maxHeight,
                        child: ListView.builder(
                          itemCount: menu.length,
                          itemBuilder: (context, index) {
                            final item = menu[index];
                            return ListTile(
                              leading: Icon(item["icon"]),
                              title: Text(
                                item["title"],
                                style: TextStyle(fontSize: 16),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () {},
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
