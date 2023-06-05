// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allergen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Allergen _$AllergenFromJson(Map<String, dynamic> json) => Allergen(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      order: json['order'] as int,
      code: json['code'] as String,
    );

Map<String, dynamic> _$AllergenToJson(Allergen instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'order': instance.order,
      'code': instance.code,
    };
