// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'cfg.g.dart';

@JsonSerializable()
class Cfg extends Equatable {
  final int id;
  final String name;
  final String value;
  final bool deleted;

  const Cfg({
    required this.id,
    required this.name,
    required this.value,
    required this.deleted,
  });

  const Cfg.empty()
      : id = 0,
        name = '',
        value = '',
        deleted = false;

  factory Cfg.fromJson(Map<String, dynamic> json) => _$CfgFromJson(json);

  Map<String, dynamic> toJson() => _$CfgToJson(this);

  bool get isEmpty =>
      id == 0 && name.isEmpty && value.isEmpty && deleted == false;

  @override
  List<Object> get props => [id, name, value, deleted];

  @override
  bool get stringify => true;
}
