import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/core/services/dashboard_control.dart';
import 'package:car_rental/core/services/order_controller.dart';
import 'package:car_rental/core/constant/currency.dart';
import 'package:car_rental/screen/order/order_widget/driver_section.dart';
import 'package:car_rental/screen/order/order_widget/total_section.dart';

import 'package:car_rental/core/widget_global/boxform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final authController = Get.find<AuthController>();
  final DashboardController controller = Get.put(DashboardController());
  final OrderController orderController = Get.find<OrderController>();
  final TextEditingController _pickedController = TextEditingController();
  final TextEditingController _returnController = TextEditingController();
  final List<String> driver = ["Without Driver", "With Driver"];
  final List<int> driverAvailable = List.generate(30, (index) => index + 1);
  String? selectedDriver;
  int? selectedDriveravailable;

  @override
  void initState() {
    super.initState();
    updateDateText();

    // Listener supaya textfield update saat tanggal berubah di controller
    ever(orderController.pickedDate, (_) {
      if (mounted) updateDateText();
    });
    ever(orderController.returnDate, (_) {
      if (mounted) updateDateText();
    });
  }

  //fungsi update data tanggal
  void updateDateText() {
    if (orderController.pickedDate.value != null) {
      _pickedController.text = orderController.pickedDate.value!
          .toLocal()
          .toString()
          .split(' ')[0];
    } else {
      _pickedController.text = '';
    }

    if (orderController.returnDate.value != null) {
      _returnController.text = orderController.returnDate.value!
          .toLocal()
          .toString()
          .split(' ')[0];
    } else {
      _returnController.text = '';
    }
  }

  //menampilkan picked data
  Future<void> showPickedDate() async {
    DateTime now = DateTime.now();
    DateTime firstDate = now;
    DateTime lasDate = now.add(Duration(days: 365));
    DateTime initial = orderController.pickedDate.value ?? now;
    if (initial.isBefore(firstDate)) {
      initial = firstDate;
      if (initial.isAfter(lasDate)) {
        initial = lasDate;
      }
    }
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      orderController.setPickedDate(picked);
    }
  }

  //menampilkan return data
  Future<void> showReturnDate() async {
    DateTime initial =
        orderController.returnDate.value ??
        (orderController.pickedDate.value != null
            ? orderController.pickedDate.value!.add(Duration(days: 1))
            : DateTime.now().add(Duration(days: 1)));

    DateTime firstDate = orderController.pickedDate.value != null
        ? orderController.pickedDate.value!.add(Duration(days: 1))
        : DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: firstDate,
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      orderController.setReturnDate(picked);
    }
  }

  @override
  void dispose() {
    _pickedController.dispose();
    _returnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.unfocusSearch,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: onInverseSurfaceColor(context),
          title: Text(
            'Order Page',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFFFF1908),
          toolbarHeight: 70,
          elevation: 2,
          shadowColor: scrimColor(context),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: controller.unfocusSearch,
          child: SafeArea(
            child: ScrollConfiguration(
              behavior: NoGlowScrollBehavior(),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //section produk mobil
                          SizedBox(height: 13),
                          Obx(() {
                            final listCar = orderController.selectedCars;
                            if (listCar.isEmpty) {
                              return Column(
                                children: [
                                  SizedBox(height: 200),
                                  Image.asset(
                                    "assets/image/nocar.png",
                                    fit: BoxFit.cover,
                                    width: 80,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "No car selected.",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: outlineColor(context),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  //section list produk mobil
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: listCar.length,
                                    itemBuilder: (context, index) {
                                      final cars = listCar[index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: outlineVariantColor(
                                                  context,
                                                ),
                                              ),
                                              color: Colors.white.withValues(
                                                alpha: 0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Container(
                                                margin: EdgeInsets.all(5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Expanded(
                                                      child: SizedBox(
                                                        child: Image.network(
                                                          cars.image,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "${cars.brand} ${cars.model}",
                                                          ),
                                                          Text(
                                                            "${cars.transmission} / ${cars.fuelType}",
                                                            style: TextStyle(
                                                              color:
                                                                  outlineColor(
                                                                    context,
                                                                  ),
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Seats: ${cars.seats}",
                                                            style: TextStyle(
                                                              color:
                                                                  outlineColor(
                                                                    context,
                                                                  ),
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${formatRp((cars.pricePerDay))} /day",
                                                            style: TextStyle(
                                                              color:
                                                                  const Color(
                                                                    0xFFFF1908,
                                                                  ),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    GestureDetector(
                                                      onTap: () {
                                                        orderController
                                                            .removeCars(cars);
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                          10,
                                                        ),
                                                        child: Container(
                                                          width: 70,
                                                          height: 35,
                                                          decoration: BoxDecoration(
                                                            color: const Color(
                                                              0xFFFF1908,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  10,
                                                                ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withValues(
                                                                      alpha:
                                                                          0.5,
                                                                    ),
                                                                offset: Offset(
                                                                  1,
                                                                  1,
                                                                ),
                                                                blurRadius: 1,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "delete",
                                                              style: TextStyle(
                                                                color:
                                                                    onInverseSurfaceColor(
                                                                      context,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  //section tanggal
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: BoxForm(
                                      label: "Picked Date",
                                      iconsPick: Icons.calendar_month,
                                      readOnly: true,
                                      onTap: showPickedDate,
                                      controller: _pickedController,
                                    ),
                                  ),
                                  SizedBox(height: 13),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: BoxForm(
                                      label: "Return Date",
                                      iconsPick: Icons.calendar_month,
                                      readOnly: true,
                                      onTap: showReturnDate,
                                      controller: _returnController,
                                    ),
                                  ),
                                  //driver section
                                  DriverSection(
                                    orderController: orderController,
                                    driverAvailable: driverAvailable,
                                    outlineVariantColor: outlineVariantColor,
                                    outlineColor: outlineColor,
                                  ),
                                  //note
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Text(
                                      "Note: Each driver service costs an additional Rp 200,000 per day, and all driver accommodations are the renter's responsibility.",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: const Color(0xFFFF1908),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Please enter your address exactly as it appears on your ID card",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: outlineColor(context),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: BoxForm(
                                      label: "Street Address",
                                      iconsPick: Icons.house,
                                      readOnly: false,
                                      controller: orderController
                                          .streetAddressController,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: BoxForm(
                                      label: "Distric",
                                      iconsPick: Icons.holiday_village,
                                      readOnly: false,
                                      controller:
                                          orderController.districtController,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: BoxForm(
                                      label: "Regency",
                                      iconsPick: Icons.streetview,
                                      readOnly: false,
                                      controller:
                                          orderController.regencyController,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 20,
                                      left: 20,
                                      bottom: 10,
                                    ),
                                    child: BoxForm(
                                      label: "Province",
                                      iconsPick: Icons.apartment,
                                      readOnly: false,
                                      controller:
                                          orderController.provinceController,
                                    ),
                                  ),
                                ],
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                  //total price section
                  TotalSection(),
                ],
              ),
            ),
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
    return child; // hilangkan glow overscroll
  }
}
