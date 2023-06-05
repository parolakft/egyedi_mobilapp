// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/nutrition.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'nutrition_info.g.dart';

@JsonSerializable()
class NutritionInfo extends Equatable {
  final int id;
  final Nutrition detail;
  final String value;

  const NutritionInfo({
    required this.id,
    required this.detail,
    required this.value,
  });

  const NutritionInfo.empty()
      : id = 0,
        detail = const Nutrition.empty(),
        value = '';

  factory NutritionInfo.fromJson(Map<String, dynamic> json) =>
      _$NutritionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionInfoToJson(this);

  bool get isEmpty => id == 0 && detail.isEmpty && value.isEmpty;

  @override
  List<Object> get props => [id, detail, value];

  @override
  bool get stringify => true;
}
