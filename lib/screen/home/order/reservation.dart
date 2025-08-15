import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/core/services/order_controller.dart';
import 'package:car_rental/core/utils/currency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  //authcontroller
  final authController = Get.find<AuthController>();
  final bookingController = Get.put(OrderController());
  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    if (authController.isLoggedIn.value) {
      bookingController.loadBooking();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: onInverseSurfaceColor(context),
        title: Text(
          'Reservations',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFF1908),
        toolbarHeight: 70,
        elevation: 2,
        shadowColor: scrimColor(context),
      ),
      body: Obx(() {
        if (!authController.isLoggedIn.value) {
          return Center(
            child: Text(
              "Please login \nto see your reservations",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: outlineColor(context),
              ),
            ),
          );
        }

        if (bookingController.isLoadingReserv.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (bookingController.reserv.isEmpty) {
          return Center(child: Text("Empty Booking"));
        }
        return Padding(
          padding: EdgeInsets.only(top: 20),
          child: ListView.builder(
            itemCount: bookingController.reserv.length,
            itemBuilder: (context, index) {
              final booking = bookingController.reserv[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Container(
                  height: 145,
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        offset: Offset(1, 2),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: booking.selectedCars.length,
                          itemBuilder: (context, index) {
                            final carItem = booking.selectedCars[index];
                            return Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(5),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Image.network(
                                    carItem.image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  "${carItem.brand} ${carItem.model}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatRp(booking.totalPrice.toInt()),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              Text(
                                "Picked Date: ${booking.pickedDate.split(" ").first}",
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                              Text(
                                "Return Date: ${booking.returnDate.split(" ").first}",
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // List gambar mobil
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
