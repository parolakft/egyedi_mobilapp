// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xy_mobil_app/allergens/repository/model/allergen.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'allergen_info.g.dart';

@JsonSerializable()
class AllergenInfo extends Equatable {
  final int id;
  final Allergen allergen;
  final String info;

  const AllergenInfo({
    required this.id,
    required this.allergen,
    required this.info,
  });

  const AllergenInfo.empty()
      : id = 0,
        allergen = const Allergen.empty(),
        info = '';

  factory AllergenInfo.fromJson(Map<String, dynamic> json) =>
      _$AllergenInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AllergenInfoToJson(this);

  bool get isEmpty => id == 0 && allergen.isEmpty && info.isEmpty;

  @override
  List<Object> get props => [id, allergen, info];

  @override
  bool get stringify => true;
}
