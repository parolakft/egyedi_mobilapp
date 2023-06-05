// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_detailed_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteDetailedListData _$VoteDetailedListDataFromJson(
        Map<String, dynamic> json) =>
    VoteDetailedListData(
      status: json['status'] as String,
      list: (json['list'] as List<dynamic>)
          .map((e) => VoteDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VoteDetailedListDataToJson(
        VoteDetailedListData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'list': instance.list,
    };
