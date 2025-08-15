import 'package:car_rental/model/car_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel {
  final int id;
  final String username;
  final String email;
  final String phone;
  final List<CarModel> selectedCars;
  final String pickedDate;
  final String returnDate;
  final String? selectedDriver;
  final int stockDriver;
  final String streetAddress;
  final String district;
  final String regency;
  final String province;
  final double totalPrice;
  final DateTime? createdAt;

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);

  BookingModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.selectedCars,
    required this.pickedDate,
    required this.returnDate,
    this.selectedDriver,
    required this.stockDriver,
    required this.streetAddress,
    required this.district,
    required this.regency,
    required this.province,
    required this.totalPrice,
    this.createdAt,
  });
}
