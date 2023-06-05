// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

String calcGrossPrice(String? price, String? vat, int round) {
  double grossPrice = price != null && price.isNotEmpty
      ? double.parse(price) * (100.0 + double.parse(vat ?? '0')) / 100.0
      : 0;
  return grossPrice.toStringAsFixed(round);
}

String calcNetPrice(String? price, String? vat, int round) {
  double netPrice = price != null && price.isNotEmpty
      ? double.parse(price) * (100.0 - double.parse(vat ?? '0')) / 100.0
      : 0;
  return netPrice.toStringAsFixed(round);
}
