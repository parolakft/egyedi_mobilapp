// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'norm.g.dart';

@JsonSerializable()
class Norm extends Equatable {
  final int id;
  final int parman;
  final String value;
  final int xyId;

  const Norm({
    required this.id,
    required this.parman,
    required this.value,
    required this.xyId,
  });

  const Norm.empty()
      : id = 0,
        parman = 0,
        value = '',
        xyId = 0;

  factory Norm.fromJson(Map<String, dynamic> json) => _$NormFromJson(json);

  Map<String, dynamic> toJson() => _$NormToJson(this);

  bool get isEmpty => id == 0 && parman == 0 && value.isEmpty && xyId == 0;

  @override
  List<Object> get props => [id, parman, value, xyId];

  @override
  bool get stringify => true;
}
