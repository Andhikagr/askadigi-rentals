import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/mainpage.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:car_rental/widget/button_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final orderController = Get.find<OrderController>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final car = orderController.selectedCar.value;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: onInverseSurfaceColor(context),
        title: Text('Order Page'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: car == null
            ? Center(child: Text("No car selected."))
            : Padding(
                padding: EdgeInsets.all(context.shortp(0.04)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: outlineColor(context)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.network(
                                car.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                SizedBox(height: context.shortp(0.08)),
                                Text(
                                  "Rp. ${car.pricePerDay}/day",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
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
              ),
      ),
    );
  }
}
