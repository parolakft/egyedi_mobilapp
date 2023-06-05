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
part 'allergens_data.g.dart';

@JsonSerializable()
class AllergensData extends Equatable {
  final String status;
  final List<Allergen> list;

  const AllergensData({
    required this.status,
    required this.list,
  });

  const AllergensData.empty()
      : status = '',
        list = const [];

  factory AllergensData.fromJson(Map<String, dynamic> json) =>
      _$AllergensDataFromJson(json);

  Map<String, dynamic> toJson() => _$AllergensDataToJson(this);

  bool get isEmpty => status.isEmpty && list.isEmpty;

  @override
  List<Object> get props => [status, list];

  @override
  bool get stringify => true;
}
