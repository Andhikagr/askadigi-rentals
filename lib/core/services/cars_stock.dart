import 'package:car_rental/core/model/booking_model.dart';
import 'package:car_rental/core/model/car_model.dart';

bool isCarAvailable(
  CarModel car,
  DateTime picked,
  DateTime returned,
  List<BookingModel> bookings,
) {
  for (var booking in bookings) {
    if (booking.status.toLowerCase() != 'paid') continue;

    final pickedDate = DateTime.parse(booking.pickedDate);
    final returnDate = DateTime.parse(booking.returnDate);

    final isCarInBooking = booking.selectedCars.any(
      (c) => c.carId.toString() == car.carId.toString(),
    );

    // cek overlap
    final isOverlap =
        picked.isBefore(returnDate) && returned.isAfter(pickedDate);

    if (isCarInBooking && isOverlap) {
      return false; // tidak available
    }
  }
  return true; // available
}
