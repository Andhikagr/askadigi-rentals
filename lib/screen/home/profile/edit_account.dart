import 'dart:io';

import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/widget/button_two.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  //authcontroller
  final authController = Get.find<AuthController>();
  late TextEditingController fullNameController;
  late TextEditingController phoneController;
  late TextEditingController photoController;

  bool isEditable = false;

  Future<void> _pickImage(GlobalKey key) async {
    final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);

    final source = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx + (box.size.width / 2) - (80 / 2),
        position.dy + box.size.height,

        position.dy + box.size.height,
        position.dx + box.size.width,
      ),
      color: Colors.grey.shade200,
      items: [
        PopupMenuItem(
          value: ImageSource.camera,
          child: SizedBox(
            width: 120,
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
            width: 120,
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

  File? imageFile;
  //savephoto

  final _picked = GlobalKey();

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(
      text: authController.username.value,
    );
    phoneController = TextEditingController(text: authController.phone.value);
    photoController = TextEditingController(
      text: authController.userPhotoPath.value,
    );
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    photoController.dispose();
  }

  void onEdit() {
    setState(() {
      isEditable = true;
    });
  }

  void onSave() async {
    await authController.updateProfil(
      newPhotoPath: photoController.text,
      newName: fullNameController.text,
      newPhone: phoneController.text,
    );
    setState(() {
      isEditable = false;
    });
    if (!mounted) return;
    Get.snackbar(
      "Succes",
      "Profile Updated",
      colorText: onInverseSurfaceColor(context),
      borderRadius: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool loggedIn = authController.isLoggedIn.value;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF1908),
          foregroundColor: onInverseSurfaceColor(context),
          toolbarHeight: 70,
          elevation: 2,
          shadowColor: scrimColor(context),
          title: Text(
            "Edit Account",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 30),
              GestureDetector(
                key: _picked,
                onTap: () => _pickImage(_picked),
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: ClipOval(
                    child: Obx(() {
                      final path = authController.userPhotoPath.value;
                      if (loggedIn && path != null && path.isNotEmpty) {
                        return Image.file(File(path), fit: BoxFit.cover);
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
              SizedBox(height: 40),
              FormEdit(
                label: "Full Name",
                readOnly: !isEditable,
                iconsPick: Icons.person,
                controller: fullNameController,
                fillColor: !isEditable
                    ? surfaceColor(context)
                    : onInverseSurfaceColor(context),
              ),
              SizedBox(height: 20),
              FormEdit(
                label: "Phone Number",
                readOnly: !isEditable,
                iconsPick: Icons.phone,
                input: TextInputType.numberWithOptions(),
                controller: phoneController,
                fillColor: !isEditable
                    ? surfaceColor(context)
                    : onInverseSurfaceColor(context),
              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: BottonTwo(
                      label: "Edit",
                      fontColor: surfaceColor(context),
                      colorBackground: isEditable
                          ? surfaceColor(context)
                          : const Color(0xFFFF1908),
                      borderColor: surfaceColor(context),
                      onTap: isEditable ? null : onEdit,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: BottonTwo(
                      label: "Save",
                      fontColor: surfaceColor(context),
                      colorBackground: isEditable
                          ? const Color(0xFFFF1908)
                          : outlineColor(context),
                      borderColor: surfaceColor(context),
                      onTap: isEditable ? onSave : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormEdit extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final IconData iconsPick;
  final TextInputType? input;
  final Color fillColor;

  const FormEdit({
    super.key,
    required this.label,
    this.controller,
    this.onTap,
    required this.readOnly,
    required this.iconsPick,
    required this.fillColor,
    this.input,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      readOnly: readOnly,
      style: TextStyle(color: outlineColor(context), fontSize: 14),
      enableSuggestions: false,
      keyboardType: input,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(iconsPick, color: outlineVariantColor(context)),
        contentPadding: EdgeInsets.all(15),
        labelText: label,
        labelStyle: TextStyle(color: outlineColor(context), fontSize: 14),
        filled: true,
        fillColor: fillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: outlineVariantColor(context),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: outlineVariantColor(context),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
