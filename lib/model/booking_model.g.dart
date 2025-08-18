// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  selectedCars: (json['selectedCars'] as List<dynamic>)
      .map((e) => CarModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  pickedDate: json['pickedDate'] as String,
  returnDate: json['returnDate'] as String,
  selectedDriver: json['selectedDriver'] as String?,
  stockDriver: (json['stockDriver'] as num).toInt(),
  streetAddress: json['streetAddress'] as String,
  district: json['district'] as String,
  regency: json['regency'] as String,
  province: json['province'] as String,
  totalPrice: (json['totalPrice'] as num).toDouble(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  status: json['status'] as String,
  paidAt: json['paidAt'] == null
      ? null
      : DateTime.parse(json['paidAt'] as String),
);

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'selectedCars': instance.selectedCars.map((e) => e.toJson()).toList(),
      'pickedDate': instance.pickedDate,
      'returnDate': instance.returnDate,
      'selectedDriver': instance.selectedDriver,
      'stockDriver': instance.stockDriver,
      'streetAddress': instance.streetAddress,
      'district': instance.district,
      'regency': instance.regency,
      'province': instance.province,
      'totalPrice': instance.totalPrice,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'paidAt': instance.paidAt?.toIso8601String(),
    };
