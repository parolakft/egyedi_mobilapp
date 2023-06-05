// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
/*

  flutter packages pub run build_runner build --delete-conflicting-outputs

 */
part 'class.g.dart';

@JsonSerializable()
class Class extends Equatable {
  final int id;
  final String name;
  final int type;
  final int priority;
  final int voteCount;

  const Class({
    required this.id,
    required this.name,
    required this.type,
    required this.priority,
    required this.voteCount,
  });
  const Class.empty()
      : id = 0,
        name = '',
        type = 0,
        priority = 0,
        voteCount = 0;
  factory Class.fromJson(Map<String, dynamic> json) => _$ClassFromJson(json);

  bool get isEmpty =>
      id == 0 && name.isEmpty && type == 0 && priority == 0 && voteCount == 0;

  Map<String, dynamic> toJson() => _$ClassToJson(this);

  @override
  List<Object> get props => [
        id,
        name,
        type,
        priority,
        voteCount,
      ];

  @override
  String toString() => 'Class($id, $name, $type, $priority, $voteCount)';
}
