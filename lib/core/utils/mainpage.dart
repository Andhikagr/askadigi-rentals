import 'package:car_rental/core/services/dashboard_control.dart';
import 'package:car_rental/screen/home/dashboard.dart';
import 'package:car_rental/screen/home/order/order.dart';
import 'package:car_rental/screen/home/profile/account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mainpage extends StatelessWidget {
  final NavController controller = Get.put(NavController());
  final DashboardController dashboardController = Get.put(
    DashboardController(),
    permanent: true,
  );

  Mainpage({super.key});

  final List<Widget> pages = [Account(), Dashboard(), Order()];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            //keyboard unfocus
            dashboardController.unfocusSearch();
            controller.selectedIndex.value = index;
          },
          items: const [
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
}

class NavController extends GetxController {
  RxInt selectedIndex = 1.obs;
}
