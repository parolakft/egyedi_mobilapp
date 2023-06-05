// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgotten_pw_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgottenPwData _$ForgottenPwDataFromJson(Map<String, dynamic> json) =>
    ForgottenPwData(
      status: json['status'] as String,
      messages: (json['messages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ForgottenPwDataToJson(ForgottenPwData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'messages': instance.messages,
    };
