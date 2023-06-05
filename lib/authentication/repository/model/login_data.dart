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
part 'login_data.g.dart';

@JsonSerializable()
class LoginData extends Equatable {
  final String status;
  final String token;
  final User user;

  const LoginData({
    required this.status,
    required this.token,
    required this.user,
  });

  const LoginData.empty()
      : status = '',
        token = '',
        user = const User.empty();

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);

  bool get isEmpty => status.isEmpty && token.isEmpty && user.isEmpty;

  @override
  List<Object> get props => [status, token, user];

  @override
  bool get stringify => true;
}
