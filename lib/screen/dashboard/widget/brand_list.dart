//section 2 dashboard
import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/dashboard_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class BrandList extends StatelessWidget {
  final DashboardController controller;

  const BrandList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        controller: controller.brandScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: controller.brand.length,
        itemBuilder: (context, index) {
          final brandName = controller.brand[index]
              .split('/')
              .last
              .split('.')
              .first
              .toLowerCase();
          return Obx(() {
            final isSelected =
                controller.selectedBrand.value.toLowerCase() == brandName;
            return GestureDetector(
              onTap: () => controller.selectBrand(brandName),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: isSelected
                        ? Colors.grey.shade400
                        : onInverseSurfaceColor(context),
                  ),
                  child: Image.asset(
                    controller.brand[index],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
