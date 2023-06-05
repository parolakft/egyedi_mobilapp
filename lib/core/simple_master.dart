// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'simple_master.g.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs

 */
@JsonSerializable()
class SimpleMaster extends Equatable {
  const SimpleMaster({
    required this.id,
    required this.code,
    required this.name,
  });

  final int id;
  @JsonKey(defaultValue: '')
  final String code;
  @JsonKey(defaultValue: '')
  final String name;

  const SimpleMaster.empty()
      : id = -1,
        code = '',
        name = '';

  factory SimpleMaster.fromJson(Map<String, dynamic> json) =>
      _$SimpleMasterFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleMasterToJson(this);

  bool get isEmpty => id == -1;

  @override
  List<Object> get props => [id, code, name];

  @override
  String toString() => 'SimpleMaster($id)';
}
