import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/core/services/order_controller.dart';
import 'package:car_rental/core/utils/currency.dart';
import 'package:car_rental/screen/home/order/booking_page.dart';
import 'package:car_rental/widget/boxform.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
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
    // DateTime initial = orderController.pickedDate.value ?? DateTime.now();
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

  //authcontroller
  final authController = Get.find<AuthController>();

  @override
  void dispose() {
    _pickedController.dispose();
    _returnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 13),
                        Obx(() {
                          final listCar = orderController.selectedCars;
                          if (listCar.isEmpty) {
                            return Column(
                              children: [
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
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
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
                                                            color: outlineColor(
                                                              context,
                                                            ),
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Seats: ${cars.seats}",
                                                          style: TextStyle(
                                                            color: outlineColor(
                                                              context,
                                                            ),
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${formatRp((cars.pricePerDay))} /day",
                                                          style: TextStyle(
                                                            color: const Color(
                                                              0xFFFF1908,
                                                            ),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Expanded(
                                                    child: GestureDetector(
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
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: BoxForm(
                                    label: "Return Date",
                                    iconsPick: Icons.calendar_month,
                                    readOnly: true,
                                    onTap: showReturnDate,
                                    controller: _returnController,
                                  ),
                                ),
                                SizedBox(height: 13),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Container(
                                    height: 54,
                                    width: 400,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: outlineVariantColor(context),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Obx(
                                        () => DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: orderController
                                                .selectedDriver
                                                .value,
                                            isExpanded: true,
                                            hint: Text("Select Driver Option"),
                                            items:
                                                [
                                                  "Without Driver",
                                                  "With Driver",
                                                ].map((option) {
                                                  return DropdownMenuItem(
                                                    value: option,
                                                    child: Text(
                                                      option,
                                                      style: TextStyle(
                                                        color: outlineColor(
                                                          context,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                            onChanged: (value) {
                                              if (value != null) {
                                                orderController
                                                        .selectedDriver
                                                        .value =
                                                    value;
                                              }
                                              if (value == "Without Driver") {
                                                orderController
                                                        .stockDriver
                                                        .value =
                                                    0;
                                              } else if (value ==
                                                      "With Driver" &&
                                                  orderController
                                                          .stockDriver
                                                          .value ==
                                                      0) {
                                                orderController
                                                        .stockDriver
                                                        .value =
                                                    1;
                                              }
                                              orderController
                                                  .updateTotalPrice();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 13),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Container(
                                    height: 54,
                                    width: 400,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: outlineVariantColor(context),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Obx(
                                        () =>
                                            orderController
                                                    .selectedDriver
                                                    .value ==
                                                "With Driver"
                                            ? DropdownButtonHideUnderline(
                                                child: DropdownButton<int>(
                                                  value: orderController
                                                      .stockDriver
                                                      .value,
                                                  items: driverAvailable
                                                      .map(
                                                        (
                                                          number,
                                                        ) => DropdownMenuItem(
                                                          value: number,
                                                          child: Text(
                                                            "${number.toString()} Driver",
                                                            style: TextStyle(
                                                              color:
                                                                  outlineColor(
                                                                    context,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      orderController
                                                              .stockDriver
                                                              .value =
                                                          value;
                                                      orderController
                                                          .updateTotalPrice();
                                                    }
                                                  },
                                                ),
                                              )
                                            : DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  items: null,
                                                  onChanged: null,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: BoxForm(
                                    label: "Street Address",
                                    iconsPick: Icons.house,
                                    readOnly: false,
                                    controller:
                                        orderController.streetAddressController,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                                "Total Price",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  formatRp(orderController.totalPrice.value),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFFF1908),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (!authController.isLoggedIn.value) {
                                Fluttertoast.showToast(
                                  msg:
                                      "You're almost there! Just need to log in first before continuing to make a reservation.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.black87,
                                  textColor: onInverseSurfaceColor(context),
                                  fontSize: 14,
                                );
                              } else if (orderController.selectedCars.isEmpty) {
                                Fluttertoast.showToast(
                                  msg:
                                      "No car selected. Please pick a car to continue.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.black87,
                                  textColor: onInverseSurfaceColor(context),
                                  fontSize: 14,
                                );
                              } else {
                                await orderController.saveOrderData();
                                final bookedData = orderController.getBooked();

                                Get.to(
                                  () => BookingPage(getBooked: bookedData),
                                  transition: Transition.native,
                                  duration: Duration(milliseconds: 1000),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFFF1908),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(
                                      alpha: 0.5,
                                    ), // perbaiki from withValues ke withOpacity
                                    offset: Offset(1, 2),
                                    blurRadius: 1,
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              child: Text(
                                "Reservation",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: onInverseSurfaceColor(context),
                                ),
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
