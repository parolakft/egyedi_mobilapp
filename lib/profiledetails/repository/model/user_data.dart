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
part 'user_data.g.dart';

@JsonSerializable()
class UserData extends Equatable {
  final String status;
  final User data;

  const UserData({
    required this.status,
    required this.data,
  });

  const UserData.empty()
      : status = '',
        data = const User.empty();

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  bool get isEmpty => status.isEmpty && data.isEmpty;

  @override
  List<Object> get props => [status, data];

  @override
  bool get stringify => true;
}
