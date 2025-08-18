import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/core/services/order_controller.dart';
import 'package:car_rental/core/utils/currency.dart';
import 'package:car_rental/screen/home/order/history.dart';
import 'package:car_rental/widget/button_two.dart';
import 'package:car_rental/widget/pay_button.dart';
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
  late final OrderController bookingController;
  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    bookingController = Get.put(OrderController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authController.isLoggedIn.value) {
        bookingController.loadBooking();
      }
    });
    ever(authController.isLoggedIn, (loggedIn) {
      if (loggedIn == true) {
        bookingController.loadBooking();
      }
    });
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
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => History(),
                transition: Transition.rightToLeft,
                duration: Duration(milliseconds: 500),
              );
            },
            icon: Icon(Icons.inventory),
            tooltip: "History",
          ),
        ],
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

        final unPaid = bookingController.reserv
            .where((search) => search.status != "paid")
            .toList();

        if (unPaid.isEmpty) {
          return Center(child: Text("Empty Booking"));
        }
        return Padding(
          padding: EdgeInsets.only(top: 10),
          child: RefreshIndicator(
            onRefresh: () async {
              await bookingController.loadBooking();
            },
            child: ListView.builder(
              itemCount: unPaid.length,
              itemBuilder: (context, index) {
                final booking = bookingController.reserv[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Container(
                    height: 200,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: 180,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1.5,
                              ),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),

                              itemCount: booking.selectedCars.length,
                              itemBuilder: (context, index) {
                                final carItem = booking.selectedCars[index];
                                return Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(5),
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 125,
                                        width: double.infinity,

                                        child: Image.network(
                                          carItem.image,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "${carItem.brand} ${carItem.model}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
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
                                const Spacer(),
                                PayButton(
                                  status: booking.status,
                                  bookingId: booking.id,
                                  totalPrice: booking.totalPrice,
                                  authController: authController,
                                  bookingController: bookingController,
                                ),

                                SizedBox(height: 10),
                                if (booking.status != "paid")
                                  ButtonTwo(
                                    label: "Cancel",
                                    fontColor: Colors.grey.shade700,
                                    colorBackground: surfaceColor(context),
                                    borderColor: Colors.grey.shade300,
                                    onTap: () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text("Cancel Booking"),
                                          content: Text(
                                            "Are you sure want to cancel?",
                                          ),
                                          actions: [
                                            InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              onTap: () =>
                                                  Navigator.pop(context, false),
                                              child: Ink(
                                                width: 80,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Colors.grey.shade300,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text("No"),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              onTap: () =>
                                                  Navigator.pop(context, true),
                                              child: Ink(
                                                width: 80,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFFFF1908,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: const Color(
                                                      0xFFFF1908,
                                                    ),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Yes",
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
                                          ],
                                        ),
                                      );
                                      if (confirm == true) {
                                        final bookingController =
                                            Get.find<OrderController>();
                                        await bookingController.deleteBooking(
                                          booking.id,
                                        );
                                      }
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
