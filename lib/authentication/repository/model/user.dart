// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xy_mobil_app/allergens/repository/model/allergen.dart';
import 'package:xy_mobil_app/authentication/repository/model/class.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs

 */
part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int id;
  final String email;
  final String name;
  final bool active;
  final String profilePic;
  final String token;
  final String facebookId;
  final String lastActivity;
  final String gender;
  final String birthdate;
  final List<Class> classes;
  final List<Allergen> allergies;
  // final List<Group> groups;
  final int votes;
  final bool hasImage;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.active,
    this.profilePic = '',
    this.token = '',
    this.facebookId = '',
    required this.lastActivity,
    required this.gender,
    this.birthdate = '',
    required this.classes,
    required this.allergies,
    // this.groups = '',
    required this.votes,
    required this.hasImage,
  });
  const User.empty()
      : id = 0,
        email = '',
        name = '',
        active = false,
        profilePic = '',
        token = '',
        facebookId = '',
        lastActivity = '',
        gender = 'UNSPECIFIED',
        birthdate = '',
        classes = const [],
        allergies = const [],
        votes = 0,
        hasImage = false;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  bool get isEmpty =>
      id == 0 &&
      email.isEmpty &&
      name.isEmpty &&
      active == false &&
      profilePic.isEmpty &&
      token.isEmpty &&
      facebookId.isEmpty &&
      lastActivity.isEmpty &&
      gender == 'UNSPECIFIED' &&
      birthdate.isEmpty &&
      classes.isEmpty &&
      allergies.isEmpty &&
      votes == 0 &&
      hasImage == false;

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [
        id,
        email,
        name,
        active,
        profilePic,
        token,
        facebookId,
        lastActivity,
        gender,
        birthdate,
        classes,
        allergies,
        votes,
        hasImage
      ];

  @override
  String toString() =>
      'User($id, $email, $name, $active, $profilePic, $token, $facebookId, $lastActivity, $gender, $birthdate, $classes, $allergies, $votes, $hasImage)';
}
