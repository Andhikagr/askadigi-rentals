// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModel _$CarModelFromJson(Map<String, dynamic> json) => CarModel(
  carId: (json['car_id'] as num).toInt(),
  brand: json['brand'] as String,
  model: json['model'] as String,
  year: (json['year'] as num).toInt(),
  image: json['image'] as String,
  description: json['description'] as String,
  transmission: json['transmission'] as String,
  fuelType: json['fuel_type'] as String,
  seats: (json['seats'] as num).toInt(),
  pricePerDay: (json['price_per_day'] as num).toInt(),
);

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
  'car_id': instance.carId,
  'brand': instance.brand,
  'model': instance.model,
  'year': instance.year,
  'image': instance.image,
  'description': instance.description,
  'transmission': instance.transmission,
  'fuel_type': instance.fuelType,
  'seats': instance.seats,
  'price_per_day': instance.pricePerDay,
};
