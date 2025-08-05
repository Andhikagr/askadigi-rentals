import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  /// Mendapatkan tinggi layar perangkat
  double get deviceHeight => MediaQuery.of(this).size.height;

  /// Mendapatkan lebar layar perangkat
  double get deviceWidth => MediaQuery.of(this).size.width;

  /// Mendapatkan sisi terpendek dari layar (untuk proporsi responsif)
  double get deviceShortSide =>
      deviceWidth < deviceHeight ? deviceWidth : deviceHeight;

  /// Mendapatkan sisi terpanjang dari layar
  double get deviceLongSide =>
      deviceWidth > deviceHeight ? deviceWidth : deviceHeight;

  /// Persentase dari tinggi layar
  double heightp(double percent) => deviceHeight * percent;

  /// Persentase dari lebar layar
  double widthp(double percent) => deviceWidth * percent;

  /// Persentase dari sisi terpendek
  double shortp(double percent) => deviceShortSide * percent;
}
