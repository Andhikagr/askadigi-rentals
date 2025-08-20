import 'package:car_rental/core/model/booking_model.dart';
import 'package:car_rental/core/model/car_model.dart';

bool carStock(CarModel car, List<BookingModel> bookings) {
  final today = DateTime.now();

  for (var booking in bookings) {
    if (booking.status != 'paid') continue;

    final pickedDate = DateTime.parse(booking.pickedDate);
    final returnDate = DateTime.parse(booking.returnDate);

    // cek apakah mobil ada di booking
    final isCarInBooking = booking.selectedCars.any(
      (c) => c.carId == car.carId,
    );

    // cek apakah hari ini termasuk periode booking
    if (isCarInBooking &&
        today.isAfter(pickedDate.subtract(Duration(days: 1))) &&
        today.isBefore(returnDate.add(Duration(days: 1)))) {
      return true;
    }
  }

  return false;
}
