import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/constant/currency.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/core/services/order_controller.dart';
import 'package:car_rental/screen/reservation/booking.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class TotalSection extends StatelessWidget {
  const TotalSection({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.find<OrderController>();
    final authController = Get.find<AuthController>();

    return Container(
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
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
                      return;
                    }
                    final validationMessage = orderController.validateOrder();
                    if (validationMessage != null) {
                      Fluttertoast.showToast(
                        msg: validationMessage,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.black87,
                        textColor: onInverseSurfaceColor(context),
                        fontSize: 14,
                      );
                      return;
                    }
                    await orderController.saveOrderData();
                    final bookedData = orderController.getBooked();

                    Get.to(
                      () => BookingPage(getBooked: bookedData),
                      transition: Transition.native,
                      duration: Duration(milliseconds: 1000),
                    );
                  },
                  child: Ink(
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
