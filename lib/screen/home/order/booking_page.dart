import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/booked.dart';
import 'package:car_rental/core/utils/currency.dart';
import 'package:flutter/material.dart';
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
                          child: Container(
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
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  item["value"],
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: primaryColor(context),
                                    fontWeight: FontWeight.bold,
                                  ),
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
                }).toList(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
