// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteData _$VoteDataFromJson(Map<String, dynamic> json) => VoteData(
      status: json['status'] as String,
      messages: json['messages'] as String? ?? '',
    );

Map<String, dynamic> _$VoteDataToJson(VoteData instance) => <String, dynamic>{
      'status': instance.status,
      'messages': instance.messages,
    };
