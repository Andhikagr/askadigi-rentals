import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  /// Mendapatkan tinggi layar perangkat
  double get deviceHeight => MediaQuery.of(this).size.height;

  /// Mendapatkan lebar layar perangkat
  double get deviceWidth => MediaQuery.of(this).size.width;
}
