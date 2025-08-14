import 'dart:convert';
import 'dart:io';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/model/car_model.dart';
import 'package:car_rental/widget/boxtext.dart';
import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/widget/car_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  final List<String> brand = [
    "assets/image/toyota.png",
    "assets/image/honda.png",
    "assets/image/hyundai.png",
    "assets/image/daihatsu.png",
    "assets/image/suzuki.png",
    "assets/image/mitsubishi.png",
  ];

  // Future<List<CarModel>> loadCarsFromJson() async {
  //   final String response = await rootBundle.loadString(
  //     "assets/data/cars.json",
  //   );
  //   final List<dynamic> data = jsonDecode(response);
  //   return data.map((cars) => CarModel.fromJson(cars)).toList();
  // }

  Future<List<CarModel>> loadCars() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/cars'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => CarModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cars from backend');
    }
  }

  String? selectedBrand;

  //authcontroller
  final authController = Get.find<AuthController>();

  //photo
  File? userPhoto;
  Future<void> loadUserPhoto() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString("user_photo");
    if (path != null && path.isNotEmpty) {
      setState(() {
        userPhoto = File(path);
      });
    }
  }

  late Future<List<CarModel>> _listOfCars;

  @override
  void initState() {
    super.initState();
    selectedBrand = "toyota";
    loadUserPhoto();
    _listOfCars = loadCars();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool loggedIn = authController.isLoggedIn.value;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFF1908),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 300,
            left: 0,
            right: 0,
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
                      expandedHeight: 100,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 20,
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
                                      "Hello",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: onInverseSurfaceColor(context),
                                      ),
                                    ),
                                    Text(
                                      "Welcome to Askadigi Rentals",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: onInverseSurfaceColor(context),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: onInverseSurfaceColor(context),
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: ClipOval(
                                    child: Obx(() {
                                      final path =
                                          authController.userPhotoPath.value;
                                      if (loggedIn &&
                                          path != null &&
                                          path.isNotEmpty) {
                                        if (userPhoto != null) {
                                          return Image.file(
                                            userPhoto!,
                                            fit: BoxFit.cover,
                                          );
                                        } else {
                                          return Image.asset(
                                            'assets/image/man.png',
                                            fit: BoxFit.cover,
                                          );
                                        }
                                      } else {
                                        return Image.asset(
                                          'assets/image/man.png',
                                          fit: BoxFit.cover,
                                        );
                                      }
                                    }),
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
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: BoxText(
                                label: "search cars",
                                iconData: Icons.search,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    "Brands",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: onInverseSurfaceColor(context),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
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
                                            horizontal: 5,
                                          ),
                                          child: Container(
                                            width: 90,

                                            margin: EdgeInsets.all(10),
                                            padding: EdgeInsets.all(12),
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
                                              fit: BoxFit.contain,
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
                          CarList(
                            futureCars: _listOfCars,
                            selectedBrand: selectedBrand,
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
