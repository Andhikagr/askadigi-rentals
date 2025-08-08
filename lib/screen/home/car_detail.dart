import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/mainpage.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:car_rental/model/car_model.dart';
import 'package:car_rental/screen/home/dashboard.dart';
import 'package:car_rental/screen/home/order.dart';
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
            final nav = Get.find<NavController>();
            nav.selectedIndex.value = 1;
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
                          padding: EdgeInsets.all(context.shortp(0.04)),
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
                              SizedBox(height: context.shortp(0.05)),
                              Hero(
                                tag: cars.image,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    cars.image,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              SizedBox(height: context.shortp(0.05)),

                              // About section
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
                              SizedBox(height: context.shortp(0.05)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Area bawah
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(context.shortp(0.03)),
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
                            color: Colors.red,
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
                                  "Rp. ${cars.pricePerDay} /day",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.red,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  final nav = Get.find<NavController>();
                                  final order = Get.find<OrderController>();

                                  order.selectedCar.value = cars;
                                  nav.selectedIndex.value = 2;
                                  Get.to(
                                    () => Order(),
                                    transition: Transition.native,
                                    duration: Duration(milliseconds: 1000),
                                  );
                                },
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
