// import 'package:car_rental/core/constant/colors.dart';
// import 'package:car_rental/core/services/order_controller.dart';
// import 'package:car_rental/core/utils/mainpage.dart';
// import 'package:car_rental/model/booked.dart';
// import 'package:car_rental/core/services/send_booking.dart';
// import 'package:car_rental/core/utils/currency.dart';
// import 'package:car_rental/screen/home/order/unproject/payment.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class BookingPage extends StatefulWidget {
//   final Booked getBooked;

//   const BookingPage({super.key, required this.getBooked});

//   @override
//   State<BookingPage> createState() => _BookingPageState();
// }

// class _BookingPageState extends State<BookingPage> {
//   bool isClicked = false;
//   String? selectedPayment;

//   @override
//   Widget build(BuildContext context) {
//     final dateFormat = DateFormat('dd MMMM yyyy');

//     String pickedDate = widget.getBooked.pickedDate.isNotEmpty
//         ? dateFormat.format(DateTime.parse(widget.getBooked.pickedDate))
//         : "";
//     String returnDate = widget.getBooked.returnDate.isNotEmpty
//         ? dateFormat.format(DateTime.parse(widget.getBooked.returnDate))
//         : "";

//     List<Map<String, dynamic>> bookingDetails = [
//       {"label": "Name :", "value": widget.getBooked.username},
//       {"label": "Email :", "value": widget.getBooked.email},
//       {"label": "Phone :", "value": widget.getBooked.phone},
//       {"label": "Picked Date :", "value": pickedDate},
//       {"label": "Return Date :", "value": returnDate},
//       {"label": "Driver Option :", "value": widget.getBooked.selectedDriver},
//       {
//         "label": "Drivers :",
//         "value": widget.getBooked.stockDriver == 0
//             ? "-"
//             : widget.getBooked.stockDriver,
//       },
//       {
//         "label": "Address :",
//         "value":
//             "${widget.getBooked.streetAddress}, ${widget.getBooked.district}, ${widget.getBooked.regency}, ${widget.getBooked.province}",
//       },
//     ];

//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: Text("Booking Detail"),
//         toolbarHeight: 70,
//         backgroundColor: const Color(0xFFFF1908),
//         foregroundColor: onInverseSurfaceColor(context),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade200),
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   children: [
//                     Align(
//                       alignment: Alignment.bottomLeft,
//                       child: Text(
//                         "Details Order",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Column(
//                       children: bookingDetails.map((item) {
//                         return Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   item["label"],
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     color: outlineColor(context),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 2,
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 5),
//                                 child: Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Text(
//                                     item["value"].toString(),
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       color: primaryColor(context),
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       }).toList(),
//                     ),
//                     SizedBox(height: 10),
//                     Align(
//                       alignment: Alignment.topLeft,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: const Color(0xFFFF1908),
//                         ),
//                         padding: EdgeInsets.symmetric(horizontal: 10),
//                         child: Text(
//                           "Car Choice",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                             color: onInverseSurfaceColor(context),
//                           ),
//                         ),
//                       ),
//                     ),
//                     ...widget.getBooked.selectedCars.map((car) {
//                       return Align(
//                         alignment: Alignment.topLeft,
//                         child: Container(
//                           padding: EdgeInsets.symmetric(vertical: 5),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "${car.brand} ${car.model}",
//                                 style: TextStyle(
//                                   color: primaryColor(context),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 "${car.year} / ${car.transmission} / ${car.fuelType}",
//                                 style: TextStyle(color: outlineColor(context)),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10),
//               Material(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.white,
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(10),
//                   splashColor: Colors.white,
//                   onTap: () {
//                     Get.to(
//                       () => Payment(),
//                       transition: Transition.downToUp,
//                       duration: Duration(milliseconds: 500),
//                     )?.then((result) {
//                       if (result != null) {
//                         setState(() {
//                           selectedPayment = result;
//                         });
//                       }
//                     });
//                   },
//                   onHighlightChanged: (value) {
//                     setState(() {
//                       isClicked = value;
//                     });
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(15),
//                     height: 70,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade200),
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.payment,
//                               size: 20,
//                               color: isClicked ? Colors.grey : Colors.black87,
//                             ),
//                             SizedBox(width: 10),
//                             Text(
//                               "Payment Method",
//                               style: TextStyle(
//                                 color: isClicked ? Colors.grey : Colors.black87,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               selectedPayment ?? "Choose Payment",
//                               style: TextStyle(
//                                 color: isClicked
//                                     ? (selectedPayment == null
//                                           ? Colors.grey
//                                           : Colors.grey)
//                                     : (selectedPayment == null
//                                           ? Colors.black87
//                                           : const Color(0xFFFF1908)),
//                               ),
//                             ),
//                             SizedBox(width: 10),
//                             Icon(
//                               Icons.arrow_forward_ios_sharp,
//                               size: 15,
//                               color: isClicked ? Colors.grey : Colors.black87,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Container(
//                 padding: EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade200),
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         RichText(
//                           text: TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: "Total : ",
//                                 style: TextStyle(
//                                   color: const Color(0xFFFF1908),
//                                   fontSize: 12, // lebih kecil
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: formatRp(widget.getBooked.totalPrice),
//                                 style: TextStyle(
//                                   color: const Color(0xFFFF1908),
//                                   fontSize: 20, // lebih besar
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         GestureDetector(
//                           onTap: () async {
//                             if (selectedPayment == null) {
//                               Get.snackbar(
//                                 "Ups",
//                                 "please select payment method first",
//                                 snackPosition: SnackPosition.BOTTOM,
//                                 backgroundColor: Colors.white,
//                                 colorText: Colors.black87,
//                                 margin: const EdgeInsets.all(10),
//                                 borderRadius: 10,
//                               );
//                               return;
//                             }

//                             final bookingController =
//                                 Get.find<OrderController>();
//                             widget.getBooked.paymentMethod = selectedPayment;
//                             await sendBooking(widget.getBooked);
//                             bookingController.clearOrderData();
//                             final nav = Get.find<NavController>();
//                             nav.selectedIndex.value = 2;
//                             Get.offAll(() => Mainpage());
//                           },

//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: const Color(0xFFFF1908),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withValues(alpha: 0.5),
//                                   offset: Offset(1, 2),
//                                   blurRadius: 1,
//                                 ),
//                               ],
//                             ),
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 20,
//                               vertical: 12,
//                             ),
//                             child: Text(
//                               "Checkout",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: onInverseSurfaceColor(context),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 12),
//                     Text(
//                       "Please complete payment within 1 hour or booking will be canceled to release the vehicle for other customers. Thank you.",
//                       textAlign: TextAlign.justify,
//                       style: TextStyle(
//                         height: 1.15,
//                         fontSize: 12,
//                         color: outlineColor(context),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
