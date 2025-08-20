import 'dart:io';

import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/core/services/dashboard_control.dart';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/screen/order/order.dart';
import 'package:car_rental/core/widget_global/boxtext.dart';
import 'package:car_rental/screen/dashboard/widget/car_list.dart';
import 'package:car_rental/screen/dashboard/widget/brand_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //Menghubungkan widget dengan controller
  final DashboardController controller = Get.find<DashboardController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFF1908),
      body: Stack(
        fit: StackFit.expand,
        children: [
          //background
          Positioned(
            top: 300,
            left: 0,
            right: 0,
            child: Image.asset("assets/image/coverred.jpg", fit: BoxFit.cover),
          ),
          GestureDetector(
            onTap: controller.unfocusSearch,
            child: SafeArea(
              child: ScrollConfiguration(
                behavior: NoGlowScrollBehavior(),
                child: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    //section 1
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: const Color(0xFFFF1908),
                      expandedHeight: 100,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: const EdgeInsets.only(
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: onInverseSurfaceColor(context),
                                      ),
                                    ),
                                    Obx(() {
                                      //Menampilkan Nama
                                      return Text(
                                        authController.username.value,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: onInverseSurfaceColor(context),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                              Obx(() {
                                //Menampilkan Foto
                                final path = authController.userPhotoPath.value;
                                return Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child:
                                        (authController.isLoggedIn.value &&
                                            path != null &&
                                            path.isNotEmpty &&
                                            controller.userPhoto.value != null)
                                        ? Image.file(
                                            File(path),
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/image/man.png',
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //section 2
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: const Color(0xFFFF1908),
                      expandedHeight: 210,
                      toolbarHeight: 220,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: BoxText(
                                label: "search cars",
                                iconData: Icons.search,
                                onChanged: controller.searchCars,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                "Brand",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: onInverseSurfaceColor(context),
                                ),
                              ),
                            ),
                            //menampilkan listview brand mobil
                            BrandList(controller: controller),
                          ],
                        ),
                      ),
                    ),
                    //section 3
                    SliverToBoxAdapter(
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              //Menampilkan listview mobil
                              () => CarList(
                                key: PageStorageKey('carList'),
                                cars: controller.cars,
                                selectedBrand: controller.selectedBrand.value,
                                searchText: controller.searchText.value,
                              ),
                            ),
                          ],
                        );
                      }),
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
