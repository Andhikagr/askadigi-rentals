import 'package:car_rental/screen/home/account.dart';
import 'package:car_rental/screen/home/dashboard.dart';
import 'package:car_rental/screen/home/order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mainpage extends StatelessWidget {
  final Navcontroller controller = Get.put(Navcontroller());

  Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.selectedIndex.value = index;
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Orders'),
          ],
        ),
      ),
    );
  }
}

class Navcontroller extends GetxController {
  RxInt selectedIndex = 1.obs;
  final pages = [Account(), Dashboard(), Order()];
}
