import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/mainpage.dart';
import 'package:car_rental/core/utils/media_query.dart';
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: cars.image,
                child: Container(
                  width: context.shortp(0.9),
                  margin: EdgeInsets.symmetric(
                    horizontal: context.shortp(0.06),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.shortp(0.02)),
                      Text(
                        "${cars.brand} ${cars.model}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${cars.transmission} / ${cars.fuelType}",
                        style: TextStyle(
                          fontSize: 14,
                          color: outlineColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: context.shortp(0.05)),
                      Align(
                        alignment: Alignment.center,
                        child: Image.network(cars.image, fit: BoxFit.cover),
                      ),
                      SizedBox(height: context.shortp(0.05)),
                      Text(
                        "About",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        cars.description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 14,
                          color: outlineColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: context.shortp(0.05)),
                      Text(
                        "Price: Rp. ${cars.pricePerDay} /day",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 20,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
