import 'dart:convert';

import 'package:car_rental/core/services/auth.dart';
import 'package:car_rental/core/services/booked.dart';
import 'package:car_rental/model/car_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController {
  var selectedCars = <CarModel>[].obs;
  var pickedDate = Rxn<DateTime>();
  var returnDate = Rxn<DateTime>();
  RxString userEmail = ''.obs;
  RxString selectedDriver = "Without Driver".obs;
  RxInt stockDriver = 0.obs;

  TextEditingController streetAddressController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController regencyController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  //authcontroller
  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    // Jangan loadOrderData di sini, tapi saat userEmail di-set dari AuthController
    ever(userEmail, (_) {
      if (userEmail.value.isNotEmpty) {
        loadOrderData();
      } else {
        clearOrderData();
      }
    });
  }

  Future<void> saveOrderData() async {
    final prefs = await SharedPreferences.getInstance();
    if (userEmail.value.isEmpty) return;

    String prefix = "order_${userEmail.value}_";

    List<String> carsJsonList = selectedCars
        .map((car) => jsonEncode(car.toJson()))
        .toList();
    await prefs.setStringList("${prefix}selectedCars", carsJsonList);

    await prefs.setString(
      "${prefix}pickedDate",
      pickedDate.value?.toIso8601String() ?? "",
    );
    await prefs.setString(
      "${prefix}returnDate",
      returnDate.value?.toIso8601String() ?? "",
    );

    //save driver data
    await prefs.setString("${prefix}selectedDriver", selectedDriver.value);
    await prefs.setInt("${prefix}stockDriver", stockDriver.value);

    await prefs.setInt("${prefix}totalPrice", totalPrice.value);

    await prefs.setString(
      "${prefix}streetAddress",
      streetAddressController.text,
    );
    await prefs.setString("${prefix}district", districtController.text);
    await prefs.setString("${prefix}regency", regencyController.text);
    await prefs.setString("${prefix}province", provinceController.text);
  }

  Future<void> loadOrderData() async {
    final prefs = await SharedPreferences.getInstance();
    if (userEmail.value.isEmpty) return;

    String prefix = "order_${userEmail.value}_";

    final carsJsonList = prefs.getStringList("${prefix}selectedCars") ?? [];
    selectedCars.value = carsJsonList
        .map((carJson) => CarModel.fromJson(jsonDecode(carJson)))
        .toList();

    final pickedDateStr = prefs.getString("${prefix}pickedDate") ?? "";
    pickedDate.value = pickedDateStr.isNotEmpty
        ? DateTime.parse(pickedDateStr)
        : null;

    final returnDateStr = prefs.getString("${prefix}returnDate") ?? "";
    returnDate.value = returnDateStr.isNotEmpty
        ? DateTime.parse(returnDateStr)
        : null;

    //load address
    streetAddressController.text =
        prefs.getString("${prefix}streetAddress") ?? "";
    districtController.text = prefs.getString("${prefix}district") ?? "";
    regencyController.text = prefs.getString("${prefix}regency") ?? "";
    provinceController.text = prefs.getString("${prefix}province") ?? "";

    //load driver option
    selectedDriver.value =
        prefs.getString("${prefix}selectedDriver") ?? "Without Driver";
    stockDriver.value = prefs.getInt("${prefix}stockDriver") ?? 0;

    totalPrice.value = prefs.getInt("${prefix}totalPrice") ?? 0;
  }

  // Total harga sewa, disimpan sebagai observable integer agar UI dapat update otomatis
  var totalPrice = 0.obs;

  //fungsi mobil
  void addCar(CarModel itemCar) {
    if (!selectedCars.contains(itemCar)) {
      selectedCars.add(itemCar);
      updateTotalPrice();
      saveOrderData();
    }
  }

  void removeCars(CarModel itemCar) {
    selectedCars.remove(itemCar);
    updateTotalPrice();
    saveOrderData();
  }

  void clearOrderData() {
    selectedCars.clear();
    pickedDate.value = null;
    returnDate.value = null;
    selectedDriver.value = "Without Driver";
    stockDriver.value = 0;
    streetAddressController.clear();
    regencyController.clear();
    provinceController.clear();
    totalPrice.value = 0;
    saveOrderData();
  }

  //Menyimpan tanggal mulai
  void setPickedDate(DateTime date) {
    pickedDate.value = date;

    //Jika tanggal kembali ada, dan lebih kecil atau sama dengan tanggal mulai,
    // maka tanggal kembali di-reset ke null supaya validasi tetap benar
    if (returnDate.value != null &&
        (returnDate.value!.isBefore(date) ||
            returnDate.value!.isAtSameMomentAs(date))) {
      returnDate.value = null;
    }
    updateTotalPrice();
    saveOrderData();
  }

  //Menyimpan tanggal kembali
  void setReturnDate(DateTime date) {
    returnDate.value = date;
    updateTotalPrice();
    saveOrderData();
  }

  // Jika tanggal mulai atau tanggal kembali belum diisi, total harga 0
  void updateTotalPrice() {
    if (pickedDate.value == null || returnDate.value == null) {
      totalPrice.value = 0;
      return;
    }

    // Hitung durasi sewa dalam hari (selisih antara returnDate dan pickedDate)
    int days = returnDate.value!.difference(pickedDate.value!).inDays;

    if (days <= 0) {
      totalPrice.value = 0;
      return;
    }
    int sum = 0;
    for (var car in selectedCars) {
      int price = (car.pricePerDay);
      sum += price * days;
    }
    if (selectedDriver.value == "With Driver" && stockDriver.value > 0) {
      sum += stockDriver.value * 200000 * days;
    }

    totalPrice.value = sum;
  }

  String? validateOrder() {
    if (selectedCars.isEmpty)
      return "No car selected. Please pick a car to continue.";
    if (pickedDate.value == null) return "Please select the start date.";
    if (returnDate.value == null) return "Please select the return date.";
    if (streetAddressController.text.isEmpty)
      return "Please enter your street address.";
    if (districtController.text.isEmpty) return "Please enter your district.";
    if (regencyController.text.isEmpty) return "Please enter your regency.";
    if (provinceController.text.isEmpty) return "Please enter your province.";
    return null; // valid
  }

  Booked getBooked() {
    return Booked(
      username: authController.username.value,
      email: authController.email.value,
      phone: authController.phone.value,
      selectedCars: selectedCars.toList(),
      pickedDate: pickedDate.value?.toIso8601String() ?? "",
      returnDate: returnDate.value?.toIso8601String() ?? "",
      selectedDriver: selectedDriver.value,
      stockDriver: stockDriver.value,
      streetAddress: streetAddressController.text,
      district: districtController.text,
      regency: regencyController.text,
      province: provinceController.text,
      totalPrice: totalPrice.value,
    );
  }
}
