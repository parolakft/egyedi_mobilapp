// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'user_settings_bloc.dart';

class UserSettingsState extends Equatable {
  const UserSettingsState({
    this.userId = 0,
    this.isStornoVisible = false,
    this.appVersion = '',
  });

  final int userId;
  final bool isStornoVisible;
  final String appVersion;

  bool get isNotEmpty => userId > 0;

  UserSettingsState copyWith({
    int? userId,
    bool? isStornoVisible,
    String? appVersion,
  }) {
    return UserSettingsState(
      userId: userId ?? this.userId,
      isStornoVisible: isStornoVisible ?? this.isStornoVisible,
      appVersion: appVersion ?? this.appVersion,
    );
  }

  @override
  List<Object> get props => [userId, isStornoVisible, appVersion];

  @override
  bool get stringify => true;
}
