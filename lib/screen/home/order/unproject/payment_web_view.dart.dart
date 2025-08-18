// import 'package:car_rental/core/services/order_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:webview_flutter/webview_flutter.dart';

// class PaymentWebView extends StatefulWidget {
//   final int bookingId;

//   const PaymentWebView({super.key, required this.bookingId});

//   @override
//   State<PaymentWebView> createState() => _PaymentWebViewState();
// }

// class _PaymentWebViewState extends State<PaymentWebView> {
//   late final WebViewController _controller;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageFinished: (_) => setState(() => isLoading = false),
//           onNavigationRequest: (request) {
//             return NavigationDecision.navigate;
//           },
//         ),
//       );

//     _loadSnapToken();
//   }

//   Future<void> _loadSnapToken() async {
//     try {
//       final token = await Get.find<OrderController>().getSnapToken(
//         widget.bookingId,
//       );
//       if (token == null) {
//         Get.snackbar(
//           "Error",
//           "Failed to get Snap token",
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//         if (!mounted) return;
//         Navigator.pop(context);
//         return;
//       }
//       final snapUrl = "https://app.sandbox.midtrans.com/snap/v2/vtweb/$token";
//       _controller.loadRequest(Uri.parse(snapUrl));
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         e.toString(),
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       if (!mounted) return;
//       Navigator.pop(context);
//     }
//   }

//   // ignore: unused_element
//   Future<void> _updateBookingPaid() async {
//     final url = Uri.parse(
//       "http://localhost:8080/pay-booking/${widget.bookingId}",
//     );
//     final res = await http.post(url);

//     if (res.statusCode == 200) {
//       Get.snackbar(
//         "Success",
//         "Payment successful",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//     if (!mounted) return;
//     Navigator.pop(context, true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             WebViewWidget(controller: _controller),
//             if (isLoading)
//               Container(
//                 color: Colors.black26,
//                 child: const Center(child: CircularProgressIndicator()),
//               ),
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 height: 60,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.transparent,
//                   boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
//                 ),
//                 child: GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Container(
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                       ),

//                       child: Icon(
//                         Icons.close_rounded,
//                         color: Color(0xFF003984),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
