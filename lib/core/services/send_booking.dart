import 'dart:convert';
import 'package:car_rental/core/services/booked.dart';
import 'package:http/http.dart' as http;

Future<void> sendBooking(Booked booking) async {
  final url = Uri.parse('http://10.0.2.2:8080/api/bookings');

  final body = jsonEncode({
    "username": booking.username,
    "email": booking.email,
    "phone": booking.phone,
    "pickedDate": booking.pickedDate,
    "returnDate": booking.returnDate,
    "selectedDriver": booking.selectedDriver,
    "stockDriver": booking.stockDriver,
    "streetAddress": booking.streetAddress,
    "district": booking.district,
    "regency": booking.regency,
    "province": booking.province,
    "totalPrice": booking.totalPrice,
    "selectedCars": booking.selectedCars
        .map(
          (car) => {
            "car_id": car.carId,
            "brand": car.brand,
            "model": car.model,
            "year": car.year,
            "transmission": car.transmission,
            "fuelType": car.fuelType,
          },
        )
        .toList(),
  });

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  if (response.statusCode == 200) {
    print("Succesfully");
  } else {
    print("failed ${response.statusCode} - ${response.body}");
  }
}
