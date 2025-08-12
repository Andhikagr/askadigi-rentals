import 'dart:io';
import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/core/services/order_controller.dart';

import 'package:car_rental/core/utils/media_query.dart';
import 'package:car_rental/screen/auth/login.dart';
import 'package:car_rental/screen/auth/signup.dart';
import 'package:car_rental/screen/home/profile/change_password.dart';
import 'package:car_rental/screen/home/profile/edit_account.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_photo", pick.path);
      setState(() {
        imageFile = File(pick.path);
      });

      return;
    }
  }

  Future<void> _loadSaveImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString("user_photo");
    if (path != null && path.isNotEmpty) {
      setState(() {
        imageFile = File(path);
      });
    }
  }

  File? imageFile;
  //savephoto

  final _picked = GlobalKey();

  //authcontroller
  final authController = Get.find<AuthController>();

  Future<void> logOut() async {
    await authController.logout();

    final orderController = Get.find<OrderController>();
    String email = orderController.userEmail.value;
    if (email.isNotEmpty) {
      final check = await SharedPreferences.getInstance();
      await check.remove("order_${email}_selectedCars");
      await check.remove("order_${email}_pickedDate");
      await check.remove("order_${email}_returnDate");
      await check.remove("order_${email}_totalPrice");
    }

    orderController.userEmail.value = '';
    orderController.clearCars();
  }

  void openWA() async {
    final phone = "6281123456789";
    final message = "Hello, i need help";
    final urlString =
        'https://wa.me/$phone?text=${Uri.encodeComponent(message)}';

    final url = Uri.parse(urlString);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("")));
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSaveImage();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menu = [
      {
        "title": "Edit Account",
        "icon": Icons.person,
        "onTap": () => Get.to(
          () => EditAccount(),
          transition: Transition.native,
          duration: Duration(milliseconds: 800),
        ),
      },
      {
        "title": "Change Password",
        "icon": Icons.lock,
        "onTap": () => Get.to(
          () => ChangePassword(),
          transition: Transition.native,
          duration: Duration(milliseconds: 800),
        ),
      },
      {
        "title": "Help & Support",
        "icon": Icons.help,
        "sub menu": [
          {
            "title": "Customer Service",
            "icon": Image.asset("assets/image/cs.png", width: 25),
            "onTap": () {
              openWA();
            },
          },
        ],
      },
    ];
    return Obx(() {
      bool loggedIn = authController.isLoggedIn.value;
      String username = authController.username.value;
      String email = authController.email.value;
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
            if (loggedIn)
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
                          height: 70,
                          width: 70,
                          child: ClipOval(
                            child: Obx(() {
                              final path = authController.userPhotoPath.value;
                              if (loggedIn && path != null && path.isNotEmpty) {
                                return Image.file(
                                  File(path),
                                  fit: BoxFit.cover,
                                );
                              } else {
                                return Image.asset(
                                  'assets/image/man.png',
                                  fit: BoxFit.cover,
                                );
                              }
                            }),
                          ),
                        ),
                      ),

                      SizedBox(width: context.shortp(0.03)),
                      SizedBox(
                        width: 250,
                        child: Padding(
                          padding: EdgeInsets.all(context.shortp(0.01)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                username,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: onSurfaceColor(context),
                                ),
                              ),
                              Text(
                                email,
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
                  if (!loggedIn)
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
                  Column(
                    children: menu.map((item) {
                      if (item.containsKey("sub menu")) {
                        return Theme(
                          data: Theme.of(
                            context,
                          ).copyWith(dividerColor: Colors.transparent),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: outlineVariantColor(context),
                              ),
                            ),

                            child: ExpansionTile(
                              iconColor: onSurfaceColor(context),
                              collapsedIconColor: onSurfaceColor(context),
                              leading: Icon(item["icon"]),
                              trailing: Icon(Icons.arrow_forward_ios),
                              title: Text(
                                item["title"],
                                style: TextStyle(fontSize: 15),
                              ),
                              children: (item["sub menu"] as List).map((
                                subItem,
                              ) {
                                return ListTile(
                                  leading: subItem["icon"],
                                  title: Text(subItem["title"]),
                                  onTap: openWA,
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: outlineVariantColor(context),
                            ),
                          ),

                          child: ListTile(
                            leading: Icon(item['icon']),
                            iconColor: onSurfaceColor(context),
                            title: Text(
                              item['title'],
                              style: TextStyle(fontSize: 15),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              final onTapCallback = item["onTap"];
                              if (onTapCallback != null &&
                                  onTapCallback is Function) {
                                onTapCallback();
                              }
                            },
                          ),
                        );
                      }
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
