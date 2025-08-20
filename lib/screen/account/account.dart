import 'dart:io';
import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/core/services/order_controller.dart';
import 'package:car_rental/screen/account/auth_page/login.dart';
import 'package:car_rental/screen/account/auth_page/signup.dart';
import 'package:car_rental/screen/account/account_widget/button_account.dart';
import 'package:car_rental/screen/account/account_widget/menu_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final authController = Get.find<AuthController>();

  //logout dan clear data
  Future<void> clearUserData() async {
    await authController.logout();
    final orderController = Get.find<OrderController>();
    String email = orderController.userEmail.value;
    if (email.isNotEmpty) {
      final check = await SharedPreferences.getInstance();
      await check.remove("order_${email}_selectedCars");
      await check.remove("order_${email}_pickedDate");
      await check.remove("order_${email}_returnDate");
      await check.remove("order_${email}_selectedDriver");
      await check.remove("order_${email}_stockDriver");
      await check.remove("order_${email}_streetAddress");
      await check.remove("order_${email}_district");
      await check.remove("order_${email}_regency");
      await check.remove("order_${email}_province");
      await check.remove("order_${email}_totalPrice");
    }
    orderController.userEmail.value = '';
    orderController.clearOrderData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool loggedIn = authController.isLoggedIn.value;
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            backgroundColor: const Color(0xFFFF1908),
            foregroundColor: onInverseSurfaceColor(context),
            automaticallyImplyLeading: false,
            title: Text(
              "Profile Account",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            actions: [
              //menampilkan tombol logout
              if (loggedIn)
                IconButton(
                  icon: Image.asset("assets/image/power.png", width: 40),
                  onPressed: () {
                    clearUserData();
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //section 1
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                            //menampilkan foto user
                            height: 70,
                            width: 70,
                            child: ClipOval(
                              child: Obx(() {
                                final path = authController.userPhotoPath.value;
                                if (loggedIn &&
                                    path != null &&
                                    path.isNotEmpty) {
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
                          SizedBox(width: 10),
                          SizedBox(
                            //menampilkan username
                            width: 250,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    authController.username.value,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: onSurfaceColor(context),
                                    ),
                                  ),
                                  Text(
                                    //menampilan user_email
                                    authController.email.value,
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
                      //login button & signup
                      SizedBox(height: 20),
                      if (!loggedIn)
                        Row(
                          children: [
                            Expanded(
                              child: ButtonAccount(
                                label: "Login",
                                colors: const Color(0xFFFF1908),
                                page: Login(),
                                textColors: onInverseSurfaceColor(context),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: ButtonAccount(
                                label: "Sign Up",
                                colors: Colors.grey.shade400,
                                page: Signup(),
                                textColors: onSurfaceColor(context),
                              ),
                            ),
                          ],
                        ),

                      //section 2 menu
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
                                  //menu help & support
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
                                      onTap: () => openWA(context),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              //menu list biasa
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
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  FocusScope.of(context).unfocus();
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
          ),
        ),
      );
    });
  }
}
