// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesData _$CategoriesDataFromJson(Map<String, dynamic> json) =>
    CategoriesData(
      status: json['status'] as String,
      list: (json['list'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoriesDataToJson(CategoriesData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'list': instance.list,
    };
