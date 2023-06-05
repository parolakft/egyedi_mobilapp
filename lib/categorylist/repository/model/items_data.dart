// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/item_tile.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'items_data.g.dart';

@JsonSerializable()
class ItemsData extends Equatable {
  final String status;
  final List<ItemTile> list;

  const ItemsData({
    required this.status,
    required this.list,
  });

  const ItemsData.empty()
      : status = '',
        list = const [];

  factory ItemsData.fromJson(Map<String, dynamic> json) =>
      _$ItemsDataFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsDataToJson(this);

  bool get isEmpty => status.isEmpty && list.isEmpty;

  @override
  List<Object> get props => [status, list];

  @override
  bool get stringify => true;
}
