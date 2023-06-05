// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'allergen.g.dart';

@JsonSerializable()
class Allergen extends Equatable {
  final int id;
  final String name;
  final String icon;
  final int order;
  final String code;

  const Allergen({
    required this.id,
    required this.name,
    required this.icon,
    required this.order,
    required this.code,
  });

  const Allergen.empty()
      : id = 0,
        name = '',
        icon = '',
        order = 0,
        code = '';

  factory Allergen.fromJson(Map<String, dynamic> json) =>
      _$AllergenFromJson(json);

  Map<String, dynamic> toJson() => _$AllergenToJson(this);

  bool get isEmpty =>
      id == 0 && name.isEmpty && icon.isEmpty && order == 0 && code.isEmpty;

  @override
  List<Object> get props => [id, name, icon, order, code];

  @override
  bool get stringify => true;
}
