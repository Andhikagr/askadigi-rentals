import 'dart:io';
import 'dart:convert';
import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/model/car_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  var cars = <CarModel>[].obs;
  var cachedCars = <CarModel>[];
  var selectedBrand = "toyota".obs;
  var userPhoto = Rxn<File>();
  final FocusNode searchBoxFocus = FocusNode();
  var filteredCars = <CarModel>[].obs;
  var searchText = "".obs;
  var brandScrollController = ScrollController();

  var isLoading = false.obs;

  final List<String> brand = [
    "assets/image/toyota.png",
    "assets/image/honda.png",
    "assets/image/hyundai.png",
    "assets/image/daihatsu.png",
    "assets/image/suzuki.png",
    "assets/image/mitsubishi.png",
  ];

  @override
  void onInit() {
    super.onInit();
    loadUserPhoto();
    loadCars();
  }

  //keyboard unfocus
  @override
  void onClose() {
    searchBoxFocus.dispose();
    super.onClose();
  }

  Future<void> loadCars() async {
    try {
      if (cachedCars.isNotEmpty) {
        cars.value = cachedCars;
      }
      isLoading.value = true;
      final response = await http
          .get(Uri.parse('http://10.0.2.2:8080/cars'))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final freshCars = data.map((json) => CarModel.fromJson(json)).toList();

        cachedCars = freshCars;

        cars.value = freshCars;
      } else {
        Get.snackbar('Error', 'Failed to load cars from backend');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadUserPhoto() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString("user_photo");
    if (path != null && path.isNotEmpty) {
      userPhoto.value = File(path);
    }
  }

  //keyboard unfocus
  void unfocusSearch() {
    searchBoxFocus.unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void selectBrand(String brandName) {
    selectedBrand.value = brandName;
  }

  void searchCars(String value, {bool fromBrand = false}) {
    searchText.value = value;

    const minText = 2;

    if (!fromBrand && value.length < minText) {
      // Klik brand → filter brand tapi tetap pakai search text
      filteredCars.value = cars
          .where(
            (car) =>
                (selectedBrand.value == 'All' ||
                    car.brand.toLowerCase() ==
                        selectedBrand.value.toLowerCase()) &&
                car.model.toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
      return;
    } else {
      if (value.isEmpty) {
        // Search kosong → tampilkan semua mobil sesuai brand
        filteredCars.value = cars
            .where(
              (car) =>
                  selectedBrand.value == 'All' ||
                  car.brand.toLowerCase() == selectedBrand.value.toLowerCase(),
            )
            .toList();
      } else {
        // Search ada teks → tampilkan satu mobil yang sesuai
        final matchedCars = cars
            .where(
              (car) => car.model.toLowerCase().contains(value.toLowerCase()),
            )
            .toList();

        if (matchedCars.isNotEmpty) {
          // Update selectedBrand dulu supaya kotak brand kuning juga mengikuti
          selectedBrand.value = matchedCars.first.brand;

          // Scroll ke brand aktif
          final index = brand.indexWhere((path) {
            final name = path.split('/').last.split('.').first.toLowerCase();
            return name == selectedBrand.value.toLowerCase();
          });

          if (index != -1) {
            brandScrollController.animateTo(
              index * 110.0, // perkiraan width item + padding
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }

          // Update filteredCars supaya tampil hanya satu mobil
          filteredCars.value = matchedCars;
        } else {
          filteredCars.value = [];
        }
      }
    }
  }

  void selectingBrand(String brand) {
    selectedBrand.value = brand;
    searchCars(searchText.value, fromBrand: true);
  }
}
