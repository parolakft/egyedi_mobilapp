// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_master.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleMaster _$SimpleMasterFromJson(Map<String, dynamic> json) => SimpleMaster(
      id: json['id'] as int,
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$SimpleMasterToJson(SimpleMaster instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };
