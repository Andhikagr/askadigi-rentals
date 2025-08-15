import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/order_controller.dart';
import 'package:car_rental/core/utils/currency.dart';
import 'package:car_rental/core/utils/mainpage.dart';
import 'package:car_rental/model/car_model.dart';
import 'package:car_rental/screen/home/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarDetail extends StatelessWidget {
  final CarModel cars;

  const CarDetail({super.key, required this.cars});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.red),
          onPressed: () {
            Get.back();
          },
        ),
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset('assets/image/coverred.jpg', fit: BoxFit.cover),
          ),
          Positioned.fill(child: Container(color: Colors.white)),
          LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: NoGlowScrollBehavior(),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${cars.brand} ${cars.model}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${cars.year} / ${cars.transmission} / ${cars.fuelType}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: outlineColor(context),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),

                              Hero(
                                tag: cars.image,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Center(
                                    child: Image.network(
                                      cars.image,
                                      width: 500,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return const Icon(Icons.error);
                                          },
                                    ),
                                  ),
                                ),
                              ),

                              // About section
                              SizedBox(height: 20),
                              Text(
                                "About",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                cars.description,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: outlineColor(context),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Area bawah
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
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
                        // Available today
                        Text(
                          "Available Today",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFF1908),
                          ),
                        ),
                        Text(
                          "Reserve your ride today and enjoy a 5% discount (limited time only)",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: outlineColor(context),
                          ),
                        ),
                        SizedBox(height: 12),
                        // Harga dan tombol
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Price",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${formatRp((cars.pricePerDay))} /day",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFFF1908),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                final nav = Get.find<NavController>();
                                final order = Get.find<OrderController>();
                                order.addCar(cars);
                                nav.selectedIndex.value = 1;
                                Get.back();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFFF1908),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.5,
                                      ),
                                      offset: Offset(1, 2),
                                      blurRadius: 1,
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),

                                child: Text(
                                  "Book Now",
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
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
