import 'package:car_rental/screen/home/dashboard.dart';
import 'package:car_rental/screen/home/order/order.dart';
import 'package:car_rental/screen/home/profile/account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mainpage extends StatelessWidget {
  final NavController controller = Get.put(NavController());

  Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _buildPage(controller.selectedIndex.value),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.selectedIndex.value = index;
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: "MyOrder",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return Account();
      case 1:
        return Dashboard();
      case 2:
        return Order();
      default:
        return Dashboard();
    }
  }
}

class NavController extends GetxController {
  RxInt selectedIndex = 1.obs;
}
