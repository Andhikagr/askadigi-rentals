import 'dart:io';

import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/media_query.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
                      Text(
                        "Account",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
                                    "Andhika Gilang Rahadian",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: onInverseSurfaceColor(context),
                                    ),
                                  ),
                                  Text(
                                    "Merden Purwanegara Banjarnegara Jawa Tengah",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: onInverseSurfaceColor(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.shortp(0.08)),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: onInverseSurfaceColor(context),
                        ),
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
