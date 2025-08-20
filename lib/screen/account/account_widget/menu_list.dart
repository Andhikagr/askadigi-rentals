import 'package:car_rental/screen/account/change_password.dart';
import 'package:car_rental/screen/account/edit_account.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

void openWA(BuildContext context) async {
  final phone = "6281123456789";
  final message = "Hello, I need help";
  final url = Uri.parse(
    'https://wa.me/$phone?text=${Uri.encodeComponent(message)}',
  );

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    Fluttertoast.showToast(
      msg: "Could not open WhatsApp",
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

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
        "onTap": (BuildContext context) {
          openWA(context);
        },
      },
    ],
  },
];
