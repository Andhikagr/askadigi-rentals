// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

// class SizeHelper {
//   final double maxWidth; // => lebar
//   final double maxHeight; // => tinggi

//   /* Constructor: menerima BoxConstraints dari LayoutBuilder 
//      dan menyimpan nilai lebar dan tinggi maksimalnya  
//   */
//   SizeHelper(BoxConstraints constraints)
//     : maxWidth = constraints.maxWidth,
//       maxHeight = constraints.maxHeight;

//   //getter mengambil lebar layar
//   double get width => maxWidth;

//   //getter mengambil tinggi layar
//   double get height => maxHeight;

//   //sisi terpendek (widget kecil)
//   double get shortSide => maxWidth < maxHeight ? maxWidth : maxHeight;

//   //sisi terpanjang
//   double get longSide => maxWidth > maxHeight ? maxWidth : maxHeight;

//   //menghitung ukuran berdasarkan presentase lebar
//   double widthp(double percent) => maxWidth * percent;
//   //menghitung ukuran berdasarkan presentase tinggi
//   double heightp(double percent) => maxHeight * percent;

//   //menghitung ukuran berdasarkan sisi terpendek agar tidak gepeng
//   double shortp(double percent) => shortSide * percent;
// }

// extension ConstraintsExt on BoxConstraints {
//   SizeHelper get sizes => SizeHelper(this);
// }

// /*

// // Untuk elemen proporsional (icon, gambar, & jarak ingin tetap proporsional di semua orientasi):
// shortp

// // Untuk layout umum (Card, TextField):
// widthp(0.9),
// heightp(0.2),


// */
