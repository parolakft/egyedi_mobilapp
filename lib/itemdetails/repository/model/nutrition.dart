// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'nutrition.g.dart';

@JsonSerializable()
class Nutrition extends Equatable {
  final int id;
  final String name;
  final String icon;
  final String fullName;
  final String details;

  const Nutrition({
    required this.id,
    required this.name,
    required this.icon,
    required this.fullName,
    required this.details,
  });

  const Nutrition.empty()
      : id = 0,
        name = '',
        icon = '',
        fullName = '',
        details = '';

  factory Nutrition.fromJson(Map<String, dynamic> json) =>
      _$NutritionFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionToJson(this);

  bool get isEmpty =>
      id == 0 &&
      name.isEmpty &&
      icon.isEmpty &&
      fullName.isEmpty &&
      details.isEmpty;

  @override
  List<Object> get props => [id, name, icon, fullName, details];

  @override
  bool get stringify => true;
}
