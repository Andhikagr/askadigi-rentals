import 'package:intl/intl.dart';

String formatRp(int number) {
  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  return formatCurrency.format(number);
}
