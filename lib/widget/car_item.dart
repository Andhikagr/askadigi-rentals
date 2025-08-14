import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/currency.dart';
import 'package:car_rental/model/car_model.dart';
import 'package:car_rental/screen/home/order/car_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// misalnya helper warna dan formatRp

class CarList extends StatelessWidget {
  final Future<List<CarModel>> futureCars;
  final String? selectedBrand;

  const CarList({super.key, required this.futureCars, this.selectedBrand});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CarModel>>(
      future: futureCars,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        }

        final allCars = snapshot.data ?? [];
        final cars = selectedBrand == null
            ? allCars
            : allCars
                  .where(
                    (car) =>
                        car.brand.toLowerCase() == selectedBrand!.toLowerCase(),
                  )
                  .toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            itemCount: cars.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final showCar = cars[index];
              return Container(
                height: 180,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: onInverseSurfaceColor(context),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${showCar.brand} ${showCar.model}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(showCar.transmission),
                            Text("Seats: ${showCar.seats}"),
                            const Spacer(),
                            Container(
                              width: 150,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: onSurfaceColor(context),
                              ),
                              child: Center(
                                child: Text(
                                  "${formatRp(showCar.pricePerDay)} /day",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: surfaceColor(context),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Get.to(
                              () => CarDetail(cars: showCar),
                              transition: Transition.native,
                              duration: const Duration(milliseconds: 600),
                            );
                          },
                          child: Hero(
                            tag: showCar.image,
                            child: Image.network(
                              showCar.image,
                              fit: BoxFit.contain,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
