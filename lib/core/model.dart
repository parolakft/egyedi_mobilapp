import 'package:json_annotation/json_annotation.dart';

enum OrderStatus {
  @JsonValue(1)
  rogzitett,
  @JsonValue(2)
  arukiadoi,
  @JsonValue(3)
  sztornozott,
  @JsonValue(4)
  kiszallitott,
  @JsonValue(5)
  atvett,
  unknown,
}

enum OrderExpiryStatus {
  expiryNotSet,
  expirySet,
  expireSoon,
  expired,
}

enum OrderAction {
  modositas,
  erkeztetes,
  megtekintes,
}
