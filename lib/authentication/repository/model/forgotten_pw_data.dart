// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'forgotten_pw_data.g.dart';

@JsonSerializable()
class ForgottenPwData extends Equatable {
  final String status;
  final List<String> messages;

  const ForgottenPwData({
    required this.status,
    this.messages = const [],
  });

  const ForgottenPwData.empty()
      : status = '',
        messages = const [];

  factory ForgottenPwData.fromJson(Map<String, dynamic> json) =>
      _$ForgottenPwDataFromJson(json);

  Map<String, dynamic> toJson() => _$ForgottenPwDataToJson(this);

  bool get isEmpty => status.isEmpty && messages.isEmpty;

  @override
  List<Object> get props => [status, messages];

  @override
  bool get stringify => true;
}
