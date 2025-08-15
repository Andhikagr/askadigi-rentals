import 'package:car_rental/model/car_model.dart';

class Booked {
  final String username;
  final String email;
  final String phone;
  final List<CarModel> selectedCars;
  final String pickedDate;
  final String returnDate;
  final String selectedDriver;
  final int stockDriver;
  final String streetAddress;
  final String district;
  final String regency;
  final String province;
  final int totalPrice;
  final DateTime? createdAt;

  Booked({
    required this.username,
    required this.email,
    required this.phone,
    required this.selectedCars,
    required this.pickedDate,
    required this.returnDate,
    required this.selectedDriver,
    required this.stockDriver,
    required this.streetAddress,
    required this.district,
    required this.regency,
    required this.province,
    required this.totalPrice,
    required this.createdAt,
  });
}
