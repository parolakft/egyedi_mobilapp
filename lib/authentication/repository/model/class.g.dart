// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Class _$ClassFromJson(Map<String, dynamic> json) => Class(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as int,
      priority: json['priority'] as int,
      voteCount: json['voteCount'] as int,
    );

Map<String, dynamic> _$ClassToJson(Class instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'priority': instance.priority,
      'voteCount': instance.voteCount,
    };
