import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/media_query.dart';
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
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.pages,
        ),
        bottomNavigationBar: Container(
          height: context.shortp(0.18),
          decoration: BoxDecoration(
            color: surfaceColor(context),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 1,
                offset: Offset(0, -1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(controller.pages.length, (index) {
              final isSelected = controller.selectedIndex.value == index;
              final icon = controller.icons[index];
              final label = controller.labels[index];

              return Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  splashColor: Colors.grey.shade300,
                  onTap: () => controller.selectedIndex.value = index,
                  child: Container(
                    width: context.shortp(0.3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isSelected
                          ? Colors.transparent
                          : Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          color: isSelected
                              ? Colors.red
                              : outlineColor(context),
                        ),
                        Text(
                          label,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.red
                                : outlineColor(context),
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

class Navcontroller extends GetxController {
  RxInt selectedIndex = 1.obs;
  final pages = [Account(), Dashboard(), Order()];
  final icons = [Icons.person, Icons.home, Icons.receipt_long];
  final labels = ["Account", "Home", "MyOrder"];
}
