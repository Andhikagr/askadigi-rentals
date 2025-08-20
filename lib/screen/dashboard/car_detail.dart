import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/cars_stock.dart';
import 'package:car_rental/core/services/order_controller.dart';
import 'package:car_rental/core/constant/currency.dart';
import 'package:car_rental/core/utils/mainpage.dart';
import 'package:car_rental/core/model/car_model.dart';
import 'package:car_rental/screen/order/order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarDetail extends StatefulWidget {
  final CarModel cars;

  const CarDetail({super.key, required this.cars});

  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  bool bookedPaid = false;

  final OrderController order = Get.find<OrderController>();

  @override
  void initState() {
    super.initState();
    order.loadBooking();
  }

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
                                "${widget.cars.brand} ${widget.cars.model}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${widget.cars.year} / ${widget.cars.transmission} / ${widget.cars.fuelType}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: outlineColor(context),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),

                              Hero(
                                tag: widget.cars.image,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Center(
                                    child: Image.network(
                                      widget.cars.image,
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
                                widget.cars.description,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  height: 1.25,
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // section available
                  Obx(() {
                    if (order.isLoadingReserv.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final bookedPaid = carStock(widget.cars, order.reserv);
                    return Container(
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
                            bookedPaid
                                ? "Not Available Today"
                                : "Available Today",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: bookedPaid
                                  ? outlineColor(context)
                                  : const Color(0xFFFF1908),
                            ),
                          ),
                          if (!bookedPaid)
                            Text(
                              "Reserve your ride today and enjoy a 5% discount (limited time only)",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: outlineColor(context),
                              ),
                            ),
                          SizedBox(height: 12),
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
                                    "${formatRp((widget.cars.pricePerDay))} /day",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFFF1908),
                                    ),
                                  ),
                                ],
                              ),
                              if (!bookedPaid)
                                Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      final nav = Get.find<NavController>();
                                      final order = Get.find<OrderController>();
                                      order.addCar(widget.cars);
                                      nav.selectedIndex.value = 1;
                                      Get.back();
                                    },
                                    child: Ink(
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
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
