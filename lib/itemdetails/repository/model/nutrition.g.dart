// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nutrition _$NutritionFromJson(Map<String, dynamic> json) => Nutrition(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      fullName: json['fullName'] as String,
      details: json['details'] as String,
    );

Map<String, dynamic> _$NutritionToJson(Nutrition instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'fullName': instance.fullName,
      'details': instance.details,
    };
