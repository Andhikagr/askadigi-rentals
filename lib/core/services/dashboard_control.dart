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
}
