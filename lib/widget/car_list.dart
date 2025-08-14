import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/currency.dart';
import 'package:car_rental/model/car_model.dart';
import 'package:car_rental/screen/home/order/car_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarList extends StatefulWidget {
  final List<CarModel> cars;
  final String? selectedBrand;
  final String? searchText;

  const CarList({
    super.key,
    required this.cars,
    this.selectedBrand,
    this.searchText,
  });

  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var filteredCars = widget.selectedBrand == null
        ? widget.cars
        : widget.cars
              .where(
                (car) =>
                    car.brand.toLowerCase() ==
                    widget.selectedBrand!.toLowerCase(),
              )
              .toList();
    if (widget.searchText != null && widget.searchText!.isNotEmpty) {
      filteredCars = filteredCars
          .where(
            (car) => car.model.toLowerCase().contains(
              widget.searchText!.toLowerCase(),
            ),
          )
          .toList();
    }
    super.build(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: filteredCars.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final showCar = filteredCars[index];
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
                            fontSize: 15,
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
                            color: const Color(0xFFFF1908),
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
                          key: ValueKey(showCar.image),
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
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
  }
}
