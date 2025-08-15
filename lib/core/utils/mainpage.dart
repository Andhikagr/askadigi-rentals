import 'package:car_rental/core/services/dashboard_control.dart';
import 'package:car_rental/screen/home/dashboard.dart';
import 'package:car_rental/screen/home/order/reservation.dart';
import 'package:car_rental/screen/home/order/order.dart';
import 'package:car_rental/screen/home/profile/account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final NavController controller = Get.put(NavController(), permanent: true);

  final DashboardController dashboardController = Get.put(
    DashboardController(),
    permanent: true,
  );

  final List<IconData> icons = [
    Icons.home,
    Icons.receipt_long,
    Icons.library_books,
    Icons.person,
  ];

  final List<String> labels = ["Home", "Order", "Reservations", "Account"];

  late final List<Widget> pages;
  @override
  void initState() {
    super.initState();
    pages = [
      Dashboard(key: PageStorageKey('dashboardPage')),
      Order(key: PageStorageKey('orderPage')),
      Reservation(key: PageStorageKey('myBooking')),
      Account(key: PageStorageKey('accountPage')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: Obx(() {
        return Container(
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
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
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
        );
      }),
    );
  }
}

class NavController extends GetxController {
  RxInt selectedIndex = 0.obs;
}
