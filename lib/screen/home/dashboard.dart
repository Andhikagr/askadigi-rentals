import 'dart:convert';

import 'package:car_rental/model/car_model.dart';
import 'package:car_rental/widget/boxtext.dart';
import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<String> brand = [
    "assets/image/toyota.png",
    "assets/image/honda.png",
    "assets/image/hyundai.png",
    "assets/image/daihatsu.png",
    "assets/image/suzuki.png",
    "assets/image/mitsubishi.png",
  ];

  Future<List<CarModel>> loadCarsFromJson() async {
    final String response = await rootBundle.loadString(
      "assets/data/carsrent.json",
    );
    final List<dynamic> data = jsonDecode(response);
    return data.map((cars) => CarModel.fromJson(cars)).toList();
  }

  late Future<List<CarModel>> _cars;
  @override
  void initState() {
    super.initState();
    _cars = loadCarsFromJson();
    selectedBrand = "toyota";
  }

  String? selectedBrand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/image/coverred.jpg", fit: BoxFit.cover),
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(context.shortp(0.02)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(context.shortp(0.02)),
                            width: context.shortp(0.12),
                            height: context.shortp(0.12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(blurRadius: 2, offset: Offset(1, 2)),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.place,
                                size: context.shortp(0.06),
                              ),
                            ),
                          ),
                          SizedBox(width: context.shortp(0.03)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your location",
                                  style: TextStyle(fontSize: 11),
                                ),
                                Text(
                                  "Banjarnegara, Central Java",
                                  style: TextStyle(
                                    fontSize: 14,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(context.widthp(0.02)),
                            width: context.shortp(0.20),
                            height: context.shortp(0.20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(blurRadius: 2, offset: Offset(1, 2)),
                              ],
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/image/man.png',
                                width: context.shortp(0.16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.shortp(0.02)),
                      BoxText(label: "search cars", iconData: Icons.search),
                      Padding(
                        padding: EdgeInsets.all(context.shortp(0.02)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Brands",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      //brand
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: context.shortp(0.22),
                          child: ListView.builder(
                            itemCount: brand.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final brandName = brand[index]
                                  .split('/')
                                  .last
                                  .split('.')
                                  .first;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedBrand = brandName;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.shortp(0.01),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(
                                      context.shortp(0.01),
                                    ),
                                    padding: EdgeInsets.all(
                                      context.shortp(0.025),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.5),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 2,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15),
                                      color: selectedBrand == brandName
                                          ? Colors.white
                                          : Colors.red,
                                    ),
                                    child: Image.asset(
                                      brand[index],
                                      width: context.shortp(0.15),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(context.shortp(0.02)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "List Cars",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      FutureBuilder<List<CarModel>>(
                        future: _cars,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text("Error"));
                          }
                          final allCars = snapshot.data!;
                          final cars = selectedBrand == null
                              ? allCars
                              : allCars
                                    .where(
                                      (car) =>
                                          car.brand.toLowerCase() ==
                                          selectedBrand!.toLowerCase(),
                                    )
                                    .toList();
                          return SizedBox(
                            child: ListView.builder(
                              itemCount: cars.length >= 2 ? 2 : cars.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final showCar = cars[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.shortp(0.01),
                                  ),
                                  child: Container(
                                    height: context.shortp(0.4),
                                    margin: EdgeInsets.symmetric(
                                      vertical: context.shortp(0.03),
                                      horizontal: context.shortp(0.01),
                                    ),
                                    padding: EdgeInsets.all(
                                      context.shortp(0.025),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),

                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFFFFFDD),
                                          offset: Offset(0, 3),
                                          blurRadius: 1,
                                        ),
                                        BoxShadow(
                                          color: const Color(0xFFFFFFDD),
                                          offset: Offset(0, -3),
                                          blurRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                context.shortp(0.02),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${showCar.brand} ${showCar.model}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    showCar.transmission,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Seats: ${showCar.seats}",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    width: context.shortp(0.35),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                      color: onSurfaceColor(
                                                        context,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                        context.shortp(0.0),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Rp. ${showCar.pricePerDay} /day",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: surfaceColor(
                                                              context,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: context.shortp(0.02)),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                context.shortp(0.02),
                                              ),
                                              child: Image.network(
                                                showCar.image,
                                                fit: BoxFit.contain,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return Icon(
                                                        Icons.broken_image,
                                                        size: context.shortp(
                                                          0.1,
                                                        ),
                                                      );
                                                    },
                                                loadingBuilder:
                                                    (context, child, progress) {
                                                      if (progress == null) {
                                                        return child;
                                                      }
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "View More",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
