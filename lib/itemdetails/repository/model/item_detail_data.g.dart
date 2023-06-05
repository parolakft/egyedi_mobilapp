// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_detail_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetailsData _$ItemDetailsDataFromJson(Map<String, dynamic> json) =>
    ItemDetailsData(
      status: json['status'] as String,
      data: ItemDetails.fromJson(json['data'] as Map<String, dynamic>),
      cfg: (json['cfg'] as List<dynamic>)
          .map((e) => Cfg.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemDetailsDataToJson(ItemDetailsData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'cfg': instance.cfg,
    };
