// import 'dart:convert';
// import 'package:car_rental/model/car_model.dart';
// import 'package:http/http.dart' as http;

// class CarService {
//   final String baseUrl = "http://10.0.2.2:8080";

//   Future<List<CarModel>> fetchCars() async {
//     final response = await http.get(Uri.parse("$baseUrl/cars"));

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonList = json.decode(response.body);
//       return jsonList.map((json) => CarModel.fromJson(json)).toList();
//     } else {
//       throw Exception("Failed to load cars");
//     }
//   }

//   Future<CarModel> fetchCarById(int id) async {
//     final response = await http.get(Uri.parse("$baseUrl/cars/$id"));

//     if (response.statusCode == 200) {
//       return CarModel.fromJson(json.decode(response.body));
//     } else {
//       throw Exception("Failed to load car");
//     }
//   }
// }
