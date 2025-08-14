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

  final List<IconData> icons = [Icons.person, Icons.home, Icons.receipt_long];

  final List<String> labels = ["Account", "Home", "MyOrder"];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: pages,
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(icons.length, (index) {
              final isSelected = controller.selectedIndex.value == index;
              return Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  splashColor: Colors.grey.shade200,
                  onTap: () {
                    dashboardController.unfocusSearch();
                    controller.selectedIndex.value = index;
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icons[index],
                          color: isSelected
                              ? const Color(0xFFFF1908)
                              : Colors.grey,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          labels[index],
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFFFF1908)
                                : Colors.grey,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class NavController extends GetxController {
  RxInt selectedIndex = 1.obs;
}
