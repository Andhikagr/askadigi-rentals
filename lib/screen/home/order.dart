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
        child: ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  final listCar = orderController.selectedCars;
                  if (listCar.isEmpty) {
                    return Center(child: Text("No car selected."));
                  }
                  return ListView.builder(
                    itemCount: listCar.length,
                    itemBuilder: (context, index) {
                      final cars = listCar[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFFC4C3C3,
                                ).withValues(alpha: 0.5),
                                offset: Offset(2, 2),
                                blurRadius: 3,
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                color: const Color(
                                  0xFFE7E7E7,
                                ).withValues(alpha: 0.5),
                                offset: Offset(-2, -2),
                                blurRadius: 3,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    child: Image.network(
                                      cars.image,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${cars.brand} ${cars.model}"),
                                      Text(
                                        "${cars.transmission} / ${cars.fuelType}",
                                        style: TextStyle(
                                          color: outlineColor(context),
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "Seats: ${cars.seats}",
                                        style: TextStyle(
                                          color: outlineColor(context),
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "Price: Rp.${cars.pricePerDay} /day",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.grey.shade200,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Rp. ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),

                          child: Text(
                            "Checkout",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: onInverseSurfaceColor(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child; // tidak munculkan efek glow
  }
}
