import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/mainpage.dart';
import 'package:car_rental/model/booked.dart';
import 'package:car_rental/core/services/send_booking.dart';
import 'package:car_rental/core/utils/currency.dart';
import 'package:car_rental/screen/home/order/reservation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatelessWidget {
  final Booked getBooked;

  const BookingPage({super.key, required this.getBooked});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMMM yyyy');

    String pickedDate = getBooked.pickedDate.isNotEmpty
        ? dateFormat.format(DateTime.parse(getBooked.pickedDate))
        : "";
    String returnDate = getBooked.returnDate.isNotEmpty
        ? dateFormat.format(DateTime.parse(getBooked.returnDate))
        : "";

    List<Map<String, dynamic>> bookingDetails = [
      {"label": "Name :", "value": getBooked.username},
      {"label": "Email :", "value": getBooked.email},
      {"label": "Phone :", "value": getBooked.phone},
      {"label": "Picked Date :", "value": pickedDate},
      {"label": "Return Date :", "value": returnDate},
      {"label": "Driver Option :", "value": getBooked.selectedDriver},
      {
        "label": "Drivers :",
        "value": getBooked.stockDriver == 0 ? "-" : getBooked.stockDriver,
      },
      {
        "label": "Address :",
        "value":
            "${getBooked.streetAddress}, ${getBooked.district}, ${getBooked.regency}, ${getBooked.province}",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Detail"),
        toolbarHeight: 70,
        backgroundColor: const Color(0xFFFF1908),
        foregroundColor: onInverseSurfaceColor(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: outlineVariantColor(context)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Column(
                  children: bookingDetails.map((item) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                item["label"],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: outlineColor(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                item["value"].toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: primaryColor(context),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Car Booked Detail",
                    style: TextStyle(
                      color: outlineColor(context),
                      fontSize: 16,
                    ),
                  ),
                ),
                ...getBooked.selectedCars.map((car) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${car.brand} ${car.model}",
                            style: TextStyle(
                              color: primaryColor(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${car.year} / ${car.transmission} / ${car.fuelType}",
                            style: TextStyle(color: outlineColor(context)),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Total Price ${formatRp(getBooked.totalPrice)}",
                    style: TextStyle(
                      color: primaryColor(context),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),

                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFFF1908)),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Text(
                    "Note:\nPlease complete payment within 1 hour or booking will be canceled to release the vehicle for other customers. Thank you.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: const Color(0xFFFF1908),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    try {
                      final succes = await sendBooking(getBooked);
                      if (succes) {
                        final nav = Get.find<NavController>();
                        nav.selectedIndex.value = 2;
                        Get.offAll(() => Mainpage());
                      } else {
                        Get.snackbar(
                          "Booking Failed",
                          "Please try again later",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    } catch (e) {
                      Get.snackbar(
                        "Error",
                        e.toString(),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
          ),
        ),
      ),
    );
  }
}
