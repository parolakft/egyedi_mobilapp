// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

bool isNumberZero(String? number) {
  return number != null && number.isNotEmpty ? double.parse(number) == 0 : true;
}
