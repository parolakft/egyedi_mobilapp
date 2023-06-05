// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:intl/intl.dart';

// Kerekítés
final normalAmountFormat = NumberFormat('#,##0.##', 'hu_HU');

final priceFormat = NumberFormat('#,##0.00', 'hu_HU');

final measuredAmountFormatters = [
  NumberFormat('#,##0', 'hu_HU'),
  NumberFormat('#,##0.0', 'hu_HU'),
  NumberFormat('#,##0.00', 'hu_HU'),
  NumberFormat('#,##0.000', 'hu_HU'),
];

NumberFormat getMeasuredAmountFormatter(String? amount) {
  if (amount == null) {
    return measuredAmountFormatters[0];
  }
  final dotPos = amount.lastIndexOf('.');
  var fractionalDigits = dotPos > -1 ? amount.length - dotPos - 1 : 3;
  if (fractionalDigits > 3) fractionalDigits = 3;
  return measuredAmountFormatters[fractionalDigits];
}
