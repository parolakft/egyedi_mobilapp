// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      email: json['email'] as String,
      name: json['name'] as String,
      active: json['active'] as bool,
      profilePic: json['profilePic'] as String? ?? '',
      token: json['token'] as String? ?? '',
      facebookId: json['facebookId'] as String? ?? '',
      lastActivity: json['lastActivity'] as String,
      gender: json['gender'] as String,
      birthdate: json['birthdate'] as String? ?? '',
      classes: (json['classes'] as List<dynamic>)
          .map((e) => Class.fromJson(e as Map<String, dynamic>))
          .toList(),
      allergies: (json['allergies'] as List<dynamic>)
          .map((e) => Allergen.fromJson(e as Map<String, dynamic>))
          .toList(),
      votes: json['votes'] as int,
      hasImage: json['hasImage'] as bool,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'active': instance.active,
      'profilePic': instance.profilePic,
      'token': instance.token,
      'facebookId': instance.facebookId,
      'lastActivity': instance.lastActivity,
      'gender': instance.gender,
      'birthdate': instance.birthdate,
      'classes': instance.classes,
      'allergies': instance.allergies,
      'votes': instance.votes,
      'hasImage': instance.hasImage,
    };
