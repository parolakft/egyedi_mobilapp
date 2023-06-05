// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemsData _$ItemsDataFromJson(Map<String, dynamic> json) => ItemsData(
      status: json['status'] as String,
      list: (json['list'] as List<dynamic>)
          .map((e) => ItemTile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemsDataToJson(ItemsData instance) => <String, dynamic>{
      'status': instance.status,
      'list': instance.list,
    };
