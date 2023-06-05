// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xy_mobil_app/categorylist/repository/model/category.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'categories_data.g.dart';

@JsonSerializable()
class CategoriesData extends Equatable {
  final String status;
  final List<Category> list;

  const CategoriesData({
    required this.status,
    required this.list,
  });

  const CategoriesData.empty()
      : status = '',
        list = const [];

  factory CategoriesData.fromJson(Map<String, dynamic> json) =>
      _$CategoriesDataFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesDataToJson(this);

  bool get isEmpty => status.isEmpty && list.isEmpty;

  @override
  List<Object> get props => [status, list];

  @override
  bool get stringify => true;
}
