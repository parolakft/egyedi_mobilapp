// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cfg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cfg _$CfgFromJson(Map<String, dynamic> json) => Cfg(
      id: json['id'] as int,
      name: json['name'] as String,
      value: json['value'] as String,
      deleted: json['deleted'] as bool,
    );

Map<String, dynamic> _$CfgToJson(Cfg instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'value': instance.value,
      'deleted': instance.deleted,
    };
