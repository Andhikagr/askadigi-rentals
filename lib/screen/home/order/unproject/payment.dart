// import 'package:car_rental/core/constant/colors.dart';
// import 'package:car_rental/core/constant/noglow.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Payment extends StatefulWidget {
//   const Payment({super.key});

//   @override
//   State<Payment> createState() => _PaymentState();
// }

// class _PaymentState extends State<Payment> {
//   String? selectedMethod;

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> method = [
//       {"label": "Bank BRI", "icon": "assets/image/bri.png"},
//       {"label": "Bank BNI", "icon": "assets/image/bni.png"},
//       {"label": "Bank BCA", "icon": "assets/image/bca.png"},
//       {"label": "Bank Mandiri", "icon": "assets/image/mandiri.png"},
//       {"label": "Bank Permata", "icon": "assets/image/permata.png"},
//       {"label": "Bank Danamon", "icon": "assets/image/danamon.png"},
//       {"label": "Gopay", "icon": "assets/image/gopay.png"},
//       {"label": "ShopeePay", "icon": "assets/image/shopeepay.png"},
//       {"label": "Qris", "icon": "assets/image/qris.png"},
//     ];

//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: Text("Payment Method"),
//         toolbarHeight: 70,
//         backgroundColor: const Color(0xFFFF1908),
//         foregroundColor: onInverseSurfaceColor(context),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: ScrollConfiguration(
//           behavior: NoGlowScrollBehavior(),
//           child: GridView.builder(
//             itemCount: method.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               mainAxisSpacing: 30,
//               crossAxisSpacing: 20,
//               childAspectRatio: 0.9,
//             ),
//             itemBuilder: (contex, index) {
//               final boxMethod = method[index];
//               // final isMethod = selectedMethod == boxMethod["label"];
//               return Material(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.transparent,
//                 child: InkWell(
//                   onTap: () {
//                     setState(() {
//                       selectedMethod = boxMethod["label"];
//                     });
//                   },
//                   borderRadius: BorderRadius.circular(10),
//                   child: Ink(
//                     padding: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(8),
//                           height: 70,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withValues(alpha: 0.1),
//                                 offset: Offset(0, 1),
//                                 blurRadius: 2,
//                               ),
//                             ],
//                           ),
//                           child: Image.asset(
//                             boxMethod["icon"],
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           boxMethod["label"],
//                           style: TextStyle(
//                             color: Colors.grey.shade800,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         width: double.infinity,
//         height: 80,
//         padding: EdgeInsets.only(left: 10, right: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 4,
//               color: Colors.grey.shade200,
//               offset: Offset(0, -2),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Select Payment Method :", style: TextStyle(fontSize: 12)),
//                 SizedBox(height: 5),
//                 Text(
//                   selectedMethod ?? "",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: const Color(0xFFFF1908),
//                   ),
//                 ),
//               ],
//             ),
//             GestureDetector(
//               onTap: selectedMethod == null
//                   ? null
//                   : () {
//                       Get.back(result: selectedMethod);
//                     },
//               child: Container(
//                 width: 200,
//                 margin: EdgeInsets.symmetric(vertical: 13),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: const Color(0xFFFF1908),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "Confirmation",
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold,
//                       color: onInverseSurfaceColor(context),
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
