// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NutritionInfo _$NutritionInfoFromJson(Map<String, dynamic> json) =>
    NutritionInfo(
      id: json['id'] as int,
      detail: Nutrition.fromJson(json['detail'] as Map<String, dynamic>),
      value: json['value'] as String,
    );

Map<String, dynamic> _$NutritionInfoToJson(NutritionInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'detail': instance.detail,
      'value': instance.value,
    };
