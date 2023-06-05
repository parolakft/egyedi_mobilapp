// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteDetail _$VoteDetailFromJson(Map<String, dynamic> json) => VoteDetail(
      id: json['id'] as int,
      detail: json['detail'] as String,
      active: json['active'] as bool,
      defaultValue: json['defaultValue'] as String,
      order: json['order'] as int? ?? 0,
    );

Map<String, dynamic> _$VoteDetailToJson(VoteDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'detail': instance.detail,
      'active': instance.active,
      'defaultValue': instance.defaultValue,
      'order': instance.order,
    };
