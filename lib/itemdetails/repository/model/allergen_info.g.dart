// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allergen_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllergenInfo _$AllergenInfoFromJson(Map<String, dynamic> json) => AllergenInfo(
      id: json['id'] as int,
      allergen: Allergen.fromJson(json['allergen'] as Map<String, dynamic>),
      info: json['info'] as String,
    );

Map<String, dynamic> _$AllergenInfoToJson(AllergenInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'allergen': instance.allergen,
      'info': instance.info,
    };
