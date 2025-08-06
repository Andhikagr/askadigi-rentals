// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModel _$CarModelFromJson(Map<String, dynamic> json) => CarModel(
  id: (json['id'] as num).toInt(),
  brand: json['brand'] as String,
  model: json['model'] as String,
  year: (json['year'] as num).toInt(),
  image: json['image'] as String,
  description: json['description'] as String,
  transmission: json['transmission'] as String,
  fuelType: json['fuelType'] as String,
  seats: (json['seats'] as num).toInt(),
  pricePerDay: json['pricePerDay'] as String,
);

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
  'id': instance.id,
  'brand': instance.brand,
  'model': instance.model,
  'year': instance.year,
  'image': instance.image,
  'description': instance.description,
  'transmision': instance.transmission,
  'fuelType': instance.fuelType,
  'seats': instance.seats,
  'pricePerDay': instance.pricePerDay,
};
