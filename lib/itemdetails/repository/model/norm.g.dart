// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'norm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Norm _$NormFromJson(Map<String, dynamic> json) => Norm(
      id: json['id'] as int,
      parman: json['parman'] as int,
      value: json['value'] as String,
      xyId: json['xyId'] as int,
    );

Map<String, dynamic> _$NormToJson(Norm instance) => <String, dynamic>{
      'id': instance.id,
      'parman': instance.parman,
      'value': instance.value,
      'xyId': instance.xyId,
    };
