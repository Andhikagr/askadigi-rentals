import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth.dart';
import '../services/order_controller.dart';
import '../../screen/reservation/payment_view.dart';
import 'button_two.dart';

class PayButton extends StatelessWidget {
  final String status;
  final int bookingId;
  final double totalPrice;
  final AuthController authController;
  final OrderController bookingController;

  const PayButton({
    super.key,
    required this.status,
    required this.bookingId,
    required this.totalPrice,
    required this.authController,
    required this.bookingController,
  });

  @override
  Widget build(BuildContext context) {
    if (status == 'draft') {
      return ButtonTwo(
        label: "Pay Now",
        fontColor: Colors.white,
        colorBackground: const Color(0xFFFF1908),
        borderColor: const Color(0xFFFF1908),
        onTap: () async {
          final result = await Get.to(
            () => PaymentView(
              bookingId: bookingId,
              totalPrice: totalPrice,
              username: authController.username.value,
              email: authController.email.value,
              phone: authController.phone.value,
            ),
          );

          if (result == true) {
            await bookingController.loadBooking();
          }
        },
      );
    } else if (status == 'pending') {
      return ButtonTwo(
        label: "Pending",
        fontColor: Colors.white,
        colorBackground: Colors.orange,
        borderColor: Colors.orange,
        onTap: null,
      );
    } else {
      return SizedBox();
    }
  }
}
