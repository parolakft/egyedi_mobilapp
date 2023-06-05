// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/cfg.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/item_details.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'item_detail_data.g.dart';

@JsonSerializable()
class ItemDetailsData extends Equatable {
  final String status;
  final ItemDetails data;
  final List<Cfg> cfg;

  const ItemDetailsData({
    required this.status,
    required this.data,
    required this.cfg,
  });

  const ItemDetailsData.empty()
      : status = '',
        data = const ItemDetails.empty(),
        cfg = const [];

  factory ItemDetailsData.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDetailsDataToJson(this);

  bool get isEmpty => status.isEmpty && data.isEmpty && cfg.isEmpty;

  @override
  List<Object> get props => [status, data, cfg];

  @override
  bool get stringify => true;
}
