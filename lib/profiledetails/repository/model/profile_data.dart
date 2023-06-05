// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xy_mobil_app/authentication/repository/model/user.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'profile_data.g.dart';

@JsonSerializable()
class ProfileData extends Equatable {
  final String status;
  final String token;
  final User user;

  const ProfileData({
    required this.status,
    required this.token,
    required this.user,
  });

  const ProfileData.empty()
      : status = '',
        token = '',
        user = const User.empty();

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);

  bool get isEmpty => status.isEmpty && token.isEmpty && user.isEmpty;

  @override
  List<Object> get props => [status, token, user];

  @override
  bool get stringify => true;
}
