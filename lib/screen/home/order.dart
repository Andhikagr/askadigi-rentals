import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/mainpage.dart';
import 'package:car_rental/widget/button_one.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: onInverseSurfaceColor(context),
        title: Text('Order Page'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Obx(() {
          final car = orderController.selectedCar.value;
          return car == null
              ? Center(child: Text("No car selected."))
              : Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: outlineVariantColor(context),
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.network(
                                car.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 200,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${car.brand} ${car.model}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${car.year} / ${car.transmission} / ${car.fuelType}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: outlineColor(context),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Rp. ${car.pricePerDay}/day",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //
                        ],
                      ),
                      Spacer(),
                      // SizedBox(height: context.shortp(0.05)),
                      buttonOne(context, "Confirm", () {}),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
