import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/order_controller.dart';
import 'package:car_rental/core/utils/currency.dart';
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
    DateTime initial = orderController.pickedDate.value ?? DateTime.now();
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
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: BoxForm(
                    label: "Picked Date",
                    readOnly: true,
                    onTap: showPickedDate,
                    controller: _pickedController,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: BoxForm(
                    label: "Return Date",
                    readOnly: true,
                    onTap: showReturnDate,
                    controller: _returnController,
                  ),
                ),
                SizedBox(height: 30),
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
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: outlineVariantColor(context),
                                ),
                                color: Colors.white.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                              "${formatRp(int.tryParse(cars.pricePerDay) ?? 0)} /day",
                                              style: TextStyle(
                                                color: const Color(0xFFFF1908),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            orderController.removeCars(cars);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Container(
                                              width: 70,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFF1908),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withValues(alpha: 0.5),
                                                    offset: Offset(1, 1),
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
                            onTap: () {
                              if (orderController.selectedCars.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: "You haven't selected any products",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.black87,
                                  textColor: onInverseSurfaceColor(context),
                                  fontSize: 14,
                                );
                              } else {
                                // Implement checkout logic here
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFFF1908),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.5),
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
                                "Checkout",
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

class BoxForm extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;

  const BoxForm({
    super.key,
    required this.label,
    this.controller,
    this.onTap,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      readOnly: readOnly,
      style: TextStyle(color: outlineColor(context)),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(
          Icons.calendar_month,
          color: outlineVariantColor(context),
        ),
        contentPadding: EdgeInsets.all(15),
        labelText: label,
        labelStyle: TextStyle(color: outlineColor(context), fontSize: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: outlineVariantColor(context),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: outlineVariantColor(context),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
