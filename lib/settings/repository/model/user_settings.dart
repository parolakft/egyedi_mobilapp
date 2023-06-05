// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_settings.g.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs

 */

@JsonSerializable()
class UserSettings extends Equatable {
  const UserSettings({required this.isStornoVisible});
  const UserSettings.empty() : isStornoVisible = false;

  final bool isStornoVisible;

  UserSettings copyWith({
    bool? isStornoVisible,
  }) {
    return UserSettings(
      isStornoVisible: isStornoVisible ?? this.isStornoVisible,
    );
  }

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$UserSettingsToJson(this);

  @override
  List<Object> get props => [isStornoVisible];
}
