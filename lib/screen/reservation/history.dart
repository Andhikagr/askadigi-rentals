import 'dart:convert';
import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/core/services/config.dart';
import 'package:car_rental/core/constant/currency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final authController = Get.find<AuthController>();
  List bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    setState(() => isLoading = true);

    try {
      final response = await http.get(Uri.parse(ApiConfig.bookings));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        setState(() {
          bookings = data;
        });
      } else {
        debugPrint("Error: ${response.body}");
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final paidBookings = bookings.where((b) => b['status'] == 'paid').toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        foregroundColor: onInverseSurfaceColor(context),
        title: Text(
          'Order History',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFF1908),
        toolbarHeight: 70,
        elevation: 2,
        shadowColor: scrimColor(context),
      ),
      body: Obx(() {
        if (authController.isLoggedIn.value) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (paidBookings.isEmpty) {
            return const Center(child: Text("No booking history"));
          } else {
            return RefreshIndicator(
              onRefresh: fetchHistory,

              child: ListView.builder(
                itemCount: paidBookings.length,
                itemBuilder: (context, index) {
                  final booking = paidBookings[index];
                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        (booking['selectedCars'] as List)
                            .map((car) => "${car['brand']} ${car['model']}")
                            .join(", "),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Price: ${formatRp(booking['totalPrice'])}",
                          ),
                          Text("Paid Method: ${booking['paymentType'] ?? '-'}"),
                          Text("Trans. ID: ${booking['transactionId'] ?? '-'}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        } else {
          return Center(
            child: Text(
              "Please login \nto view your booking history",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: outlineColor(context),
              ),
            ),
          );
        }
      }),
    );
  }
}
