// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'user_settings_bloc.dart';

abstract class UserSettingsEvent extends Equatable {
  const UserSettingsEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class UserChanged extends UserSettingsEvent {
  const UserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class IsStornoVisibleChanged extends UserSettingsEvent {
  const IsStornoVisibleChanged(this.isStornoVisible);

  final bool isStornoVisible;

  @override
  List<Object> get props => [isStornoVisible];
}

class VersionRequested extends UserSettingsEvent {}
