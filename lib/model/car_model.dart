import 'package:json_annotation/json_annotation.dart';

part 'car_model.g.dart';

@JsonSerializable()
class CarModel {
  final int id;
  final String brand;
  final String model;
  final int year;
  final String image;
  final String description;
  final String transmission;
  final String fuelType;
  final int seats;
  final String pricePerDay;

  Map<String, dynamic> toJson() => _$CarModelToJson(this);
  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);

  CarModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.image,
    required this.description,
    required this.transmission,
    required this.fuelType,
    required this.seats,
    required this.pricePerDay,
  });
}

/*
run this in terminal
dart run build_runner build --delete-conflicting-outputs
*/
