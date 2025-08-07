import 'dart:convert';

import 'package:car_rental/model/car_model.dart';
import 'package:car_rental/screen/home/car_detail.dart';
import 'package:car_rental/widget/boxtext.dart';
import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/utils/media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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

  String? selectedBrand;

  @override
  void initState() {
    super.initState();
    _cars = loadCarsFromJson();
    selectedBrand = "toyota";

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFF1908),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            top: 310,
            child: Image.asset("assets/image/coverred.jpg", fit: BoxFit.cover),
          ),
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: ScrollConfiguration(
                behavior: NoGlowScrollBehavior(),
                child: CustomScrollView(
                  physics: ClampingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      stretch: false,
                      automaticallyImplyLeading: false,
                      backgroundColor: const Color(0xFFFF1908),
                      expandedHeight: context.shortp(0.22),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: EdgeInsets.only(
                            top: context.shortp(0.02),
                            left: context.shortp(0.03),
                            right: context.shortp(0.03),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Your location",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: onInverseSurfaceColor(context),
                                      ),
                                    ),
                                    Text(
                                      "Banjarnegara, Central Java",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: onInverseSurfaceColor(context),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: context.shortp(0.20),
                                height: context.shortp(0.20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: onInverseSurfaceColor(context),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
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
                        ),
                      ),
                    ),
                    SliverAppBar(
                      stretch: false,
                      automaticallyImplyLeading: false,
                      backgroundColor: const Color(0xFFFF1908),
                      expandedHeight: 210,
                      toolbarHeight: 220,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: context.shortp(0.03)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.shortp(0.03),
                              ),
                              child: BoxText(
                                label: "search cars",
                                iconData: Icons.search,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: context.shortp(0.04)),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.shortp(0.04),
                                  ),
                                  child: Text(
                                    "Brands",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: onInverseSurfaceColor(context),
                                    ),
                                  ),
                                ),
                                SizedBox(height: context.shortp(0.02)),
                                SizedBox(
                                  height: context.shortp(0.22),
                                  child: ListView.builder(
                                    itemCount: brand.length,
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
                                              border: Border.all(
                                                color: onInverseSurfaceColor(
                                                  context,
                                                ),
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: selectedBrand == brandName
                                                  ? Colors.amberAccent
                                                  : onInverseSurfaceColor(
                                                      context,
                                                    ),
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
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.shortp(0.03)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.shortp(0.03),
                            ),
                            child: Text(
                              "List Cars",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: onInverseSurfaceColor(context),
                              ),
                            ),
                          ),

                          FutureBuilder<List<CarModel>>(
                            future: _cars,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
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

                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.shortp(0.03),
                                ),
                                child: ListView.builder(
                                  itemCount: cars.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final showCar = cars[index];
                                    return Container(
                                      height: context.shortp(0.4),
                                      margin: EdgeInsets.symmetric(
                                        vertical: context.shortp(0.03),
                                        horizontal: context.shortp(0.01),
                                      ),
                                      padding: EdgeInsets.all(
                                        context.shortp(0.025),
                                      ),
                                      decoration: BoxDecoration(
                                        color: onInverseSurfaceColor(context),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
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
                                                  Text(showCar.transmission),
                                                  Text(
                                                    "Seats: ${showCar.seats}",
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
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: context.shortp(0.02)),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                context.shortp(0.02),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(
                                                    context,
                                                  ).unfocus();
                                                  Get.to(
                                                    () => CarDetail(
                                                      cars: showCar,
                                                    ),
                                                    transition:
                                                        Transition.native,
                                                    duration: Duration(
                                                      milliseconds: 100,
                                                    ),
                                                  );
                                                },

                                                child: Hero(
                                                  tag: showCar.image,
                                                  child: Image.network(
                                                    showCar.image,
                                                    fit: BoxFit.contain,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) => Icon(
                                                          Icons.broken_image,
                                                          size: context.shortp(
                                                            0.1,
                                                          ),
                                                        ),
                                                    loadingBuilder:
                                                        (
                                                          context,
                                                          child,
                                                          progress,
                                                        ) {
                                                          if (progress ==
                                                              null) {
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
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child; // tidak munculkan efek glow
  }
}
