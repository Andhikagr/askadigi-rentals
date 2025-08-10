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

  @override
  void initState() {
    super.initState();

    // Ambil tanggal mulai yang sudah disimpan di controller,
    if (orderController.pickedDate.value != null) {
      _pickedController.text = "${orderController.pickedDate.value!.toLocal()}"
          .split(' ')[0];
    }
    // Ambil tanggal kembali yang sudah disimpan di controller,
    if (orderController.returnDate.value != null) {
      _returnController.text = "${orderController.returnDate.value!.toLocal()}"
          .split(' ')[0];
    }

    // Pasang listener menggunakan GetX "ever" untuk observasi setiap perubahan pickedDate.
    // Setiap kali pickedDate berubah, kita update text controller supaya UI ikut update.

    //untuk tanggal mulai
    ever(orderController.pickedDate, (DateTime? date) {
      if (date != null) {
        _pickedController.text = "${date.toLocal()}".split(' ')[0];
      } else {
        _pickedController.text = "";
      }
    });
    //untuk tanggal kembali
    ever(orderController.returnDate, (DateTime? date) {
      if (date != null) {
        _returnController.text = "${date.toLocal()}".split(' ')[0];
      } else {
        _returnController.text = "";
      }
    });
  }

  //Menampilkan data picker
  void showPickedDate() async {
    final now = DateTime.now();

    //batas minimal hari ini dan maksimal tahun 2050
    final picked = await showDatePicker(
      context: context,
      // default tanggal saat ini atau tanggal yang sudah dipilih
      initialDate: orderController.pickedDate.value ?? now,
      firstDate: now, // tidak bisa memilih tanggal sebelum hari ini
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      // Update tanggal mulai di controller agar reactive system berjalan dan UI update otomatis
      orderController.setPickedDate(picked);
    }
  }

  void showReturnDate() async {
    if (orderController.pickedDate.value == null) {
      // Jika tanggal mulai belum dipilih, jangan izinkan pilih tanggal kembali
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select picked date first")),
      );
      return;
    }

    // Panggil showDatePicker dengan batasan minimal tanggal kembali adalah satu hari setelah tanggal mulai,
    // supaya tanggal kembali tidak lebih awal dari tanggal mulai
    final timeAllowed = await showDatePicker(
      context: context,
      initialDate:
          orderController.returnDate.value ??
          orderController.pickedDate.value!.add(Duration(days: 1)),
      firstDate: orderController.pickedDate.value!.add(Duration(days: 1)),
      lastDate: DateTime(2050),
    );
    // Jika user memilih tanggal kembali, update di controller
    if (timeAllowed != null) {
      orderController.setReturnDate(timeAllowed);
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
                          Container(
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
