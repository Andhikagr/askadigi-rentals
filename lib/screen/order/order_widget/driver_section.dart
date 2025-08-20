// driver_section.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverSection extends StatelessWidget {
  final dynamic orderController; // ganti sesuai tipe controller-mu
  final List<int> driverAvailable;
  final Color Function(BuildContext) outlineVariantColor;
  final Color Function(BuildContext) outlineColor;

  const DriverSection({
    super.key,
    required this.orderController,
    required this.driverAvailable,
    required this.outlineVariantColor,
    required this.outlineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 13),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          // section driver option
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: outlineVariantColor(context)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Obx(
                () => DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: orderController.selectedDriver.value,
                    isExpanded: true,
                    hint: const Text("Select Driver Option"),
                    items: ["Without Driver", "With Driver"].map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(
                          option,
                          style: TextStyle(color: outlineColor(context)),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        orderController.selectedDriver.value = value;
                      }
                      if (value == "Without Driver") {
                        orderController.stockDriver.value = 0;
                      } else if (value == "With Driver" &&
                          orderController.stockDriver.value == 0) {
                        orderController.stockDriver.value = 1;
                      }
                      orderController.updateTotalPrice();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 13),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          // section jumlah driver
          child: Container(
            height: 54,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: outlineVariantColor(context)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Obx(
                () => orderController.selectedDriver.value == "With Driver"
                    ? DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: orderController.stockDriver.value,
                          isExpanded: true,
                          items: driverAvailable.map((number) {
                            return DropdownMenuItem(
                              value: number,
                              child: Text(
                                "${number.toString()} Driver",
                                style: TextStyle(color: outlineColor(context)),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              orderController.stockDriver.value = value;
                              orderController.updateTotalPrice();
                            }
                          },
                        ),
                      )
                    : DropdownButtonHideUnderline(
                        child: DropdownButton(items: null, onChanged: null),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
