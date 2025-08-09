import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/currency.dart';
import 'package:car_rental/core/utils/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final orderController = Get.find<OrderController>();
  final TextEditingController _pickedController = TextEditingController();
  final TextEditingController _returnController = TextEditingController();

  DateTime? _pickedDate;
  DateTime? _returnDate;

  void showPickedDate() async {
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(2050),
      initialDate: _pickedDate ?? now,
    );
    if (pickedDate != null) {
      setState(() {
        _pickedDate = pickedDate;
        _pickedController.text = "${pickedDate.toLocal()}".split(" ")[0];
        if (_returnDate != null &&
            (_returnDate!.isBefore(_pickedDate!) ||
                _returnDate!.isAtSameMomentAs(_pickedDate!))) {
          _returnDate = null;
          _returnController.text = "";
        }
      });
    }
    updateTotalPrice();
  }

  void showReturnDate() async {
    if (_pickedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please select date first")));
      return;
    }

    final DateTime? returnDate = await showDatePicker(
      context: context,
      firstDate: _pickedDate!.add(Duration(days: 1)),
      lastDate: DateTime(2050),
      initialDate: _returnDate ?? _pickedDate!.add(Duration(days: 1)),
    );
    if (returnDate != null) {
      setState(() {
        _returnDate = returnDate;
        _returnController.text = "${returnDate.toLocal()}".split(" ")[0];
      });
    }
    updateTotalPrice();
  }

  int getRentDays() {
    if (_pickedDate == null || _returnDate == null) return 0;
    return _returnDate!.difference(_pickedDate!).inDays;
  }

  int getTotalPrice() {
    final days = getRentDays();
    if (days == 0) return 0;

    int total = 0;
    for (var car in orderController.selectedCars) {
      int price = int.tryParse(car.pricePerDay) ?? 0;
      total += price * days;
    }
    return total;
  }

  final RxInt totalPrice = 0.obs;
  void updateTotalPrice() {
    totalPrice.value = getTotalPrice();
  }

  @override
  void initState() {
    super.initState();
    ever(orderController.selectedCars, (_) => updateTotalPrice());
  }

  @override
  void dispose() {
    super.dispose();
    _pickedController.dispose();
    _returnController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  BoxForm(
                    label: "Picked Date",
                    readOnly: true,
                    onTap: showPickedDate,
                    controller: _pickedController,
                  ),
                  SizedBox(height: 20),
                  BoxForm(
                    label: "Return Date",
                    readOnly: true,
                    onTap: showReturnDate,
                    controller: _returnController,
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
                          return Container(
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
                                          updateTotalPrice();
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
                                            ),
                                            child: Center(
                                              child: Text(
                                                "delete",
                                                style: TextStyle(
                                                  color: onInverseSurfaceColor(
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
                                    formatRp(totalPrice.value),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFFF1908),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xFFFF1908),
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
  }); // => untuk membuka datapicker/timepicker

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
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: outlineVariantColor(context),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: outlineVariantColor(context),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
