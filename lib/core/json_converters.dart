// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

class HuDateTimeConverter implements JsonConverter<DateTime, String> {
  const HuDateTimeConverter();

  @override
  DateTime fromJson(String json) => DateFormat.yMd('hu_HU').parse(json);

  @override
  String toJson(DateTime object) => DateFormat.yMd('hu_HU').format(object);
}
