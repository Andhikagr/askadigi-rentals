import 'package:car_rental/core/constant/colors.dart';
import 'package:car_rental/model/car_model.dart';
import 'package:car_rental/screen/home/account.dart';
import 'package:car_rental/screen/home/dashboard.dart';
import 'package:car_rental/screen/home/order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mainpage extends StatelessWidget {
  final NavController controller = Get.put(NavController());
  final OrderController orderController = Get.put(
    OrderController(),
    permanent: true,
  );

  Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.pages,
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            color: surfaceColor(context),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 1,
                offset: Offset(0, -1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(controller.pages.length, (index) {
              final isSelected = controller.selectedIndex.value == index;
              final icon = controller.icons[index];
              final label = controller.labels[index];

              return Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  splashColor: Colors.grey.shade300,
                  onTap: () => controller.selectedIndex.value = index,
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isSelected
                          ? Colors.transparent
                          : Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          color: isSelected
                              ? const Color(0xFFFF1908)
                              : outlineColor(context),
                        ),
                        Text(
                          label,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFFFF1908)
                                : outlineColor(context),
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class NavController extends GetxController {
  RxInt selectedIndex = 1.obs;
  final pages = [Account(), Dashboard(), Order()];
  final icons = [Icons.person, Icons.home, Icons.receipt_long];
  final labels = ["Account", "Home", "MyOrder"];
}

class OrderController extends GetxController {
  var selectedCars = <CarModel>[].obs;

  // variabel tanggal mulai sewa fitur reactive
  Rx<DateTime?> pickedDate = Rx<DateTime?>(null);
  Rx<DateTime?> returnDate = Rx<DateTime?>(null);

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
