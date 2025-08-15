import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/core/services/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  //authcontroller
  final authController = Get.find<AuthController>();
  final bookingController = Get.put(OrderController());

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

        return ListView.builder(
          itemCount: bookingController.reserv.length,
          itemBuilder: (context, index) {
            final booking = bookingController.reserv[index];
            return ListTile(
              title: Text(booking.username),
              subtitle: Text("${booking.pickedDate} - ${booking.returnDate} "),
            );
          },
        );
      }),
    );
  }
}
