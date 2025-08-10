import 'dart:convert';

import 'package:car_rental/model/car_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController {
  var selectedCars = <CarModel>[].obs;
  var pickedDate = Rxn<DateTime>();
  var returnDate = Rxn<DateTime>();
  RxString userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Jangan loadOrderData di sini, tapi saat userEmail di-set dari AuthController
    ever(userEmail, (_) {
      if (userEmail.value.isNotEmpty) {
        loadOrderData();
      } else {
        clearCars();
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
    await prefs.setStringList(prefix + "selectedCars", carsJsonList);

    await prefs.setString(
      prefix + "pickedDate",
      pickedDate.value?.toIso8601String() ?? "",
    );
    await prefs.setString(
      prefix + "returnDate",
      returnDate.value?.toIso8601String() ?? "",
    );

    await prefs.setInt(prefix + "totalPrice", totalPrice.value);
  }

  Future<void> loadOrderData() async {
    final prefs = await SharedPreferences.getInstance();
    if (userEmail.value.isEmpty) return;

    String prefix = "order_${userEmail.value}_";

    final carsJsonList = prefs.getStringList(prefix + "selectedCars") ?? [];
    selectedCars.value = carsJsonList
        .map((carJson) => CarModel.fromJson(jsonDecode(carJson)))
        .toList();

    final pickedDateStr = prefs.getString(prefix + "pickedDate") ?? "";
    pickedDate.value = pickedDateStr.isNotEmpty
        ? DateTime.parse(pickedDateStr)
        : null;

    final returnDateStr = prefs.getString(prefix + "returnDate") ?? "";
    returnDate.value = returnDateStr.isNotEmpty
        ? DateTime.parse(returnDateStr)
        : null;

    totalPrice.value = prefs.getInt(prefix + "totalPrice") ?? 0;
  }

  // Total harga sewa, disimpan sebagai observable integer agar UI dapat update otomatis
  var totalPrice = 0.obs;

  //fungsi mobil
  void addCar(CarModel itemCar) {
    if (!selectedCars.contains(itemCar)) {
      selectedCars.add(itemCar);
      updateTotalPrice();
    }
  }

  void removeCars(CarModel itemCar) {
    selectedCars.remove(itemCar);
    updateTotalPrice();
  }

  void clearCars() {
    selectedCars.clear();
    pickedDate.value = null;
    returnDate.value = null;
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
  }

  //Menyimpan tanggal kembali
  void setReturnDate(DateTime date) {
    returnDate.value = date;
    updateTotalPrice();
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
      int price = int.tryParse(car.pricePerDay) ?? 0;
      sum += price * days;
    }
    totalPrice.value = sum;
  }
}
