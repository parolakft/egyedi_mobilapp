// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_state.g.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs

 */

@JsonSerializable()
class UserState extends Equatable {
  const UserState({required this.lastUsedPartnerId});
  const UserState.empty() : lastUsedPartnerId = 0;

  final int lastUsedPartnerId;
  // TODO az éppen szerkesztés alatt levő OrderDetail

  UserState copyWith({int? lastUsedPartnerId}) {
    return UserState(
      lastUsedPartnerId: lastUsedPartnerId ?? this.lastUsedPartnerId,
    );
  }

  factory UserState.fromJson(Map<String, dynamic> json) =>
      _$UserStateFromJson(json);

  Map<String, dynamic> toJson() => _$UserStateToJson(this);

  @override
  List<Object> get props => [lastUsedPartnerId];
}
