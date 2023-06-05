// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allergens_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllergensData _$AllergensDataFromJson(Map<String, dynamic> json) =>
    AllergensData(
      status: json['status'] as String,
      list: (json['list'] as List<dynamic>)
          .map((e) => Allergen.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllergensDataToJson(AllergensData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'list': instance.list,
    };
