// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class NavigationRefreshRequested extends ProfileEvent {
  const NavigationRefreshRequested(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class GenderChangeRequested extends ProfileEvent {
  const GenderChangeRequested(this.gender);

  final String gender;

  @override
  List<Object> get props => [gender];
}

class BirthDateChangeRequested extends ProfileEvent {
  const BirthDateChangeRequested(this.date);

  final String date;

  @override
  List<Object> get props => [date];
}

class AllergiesChangeRequested extends ProfileEvent {}

class PasswordChangeRequested extends ProfileEvent {
  const PasswordChangeRequested(this.password, this.newPassword);

  final String password;
  final String newPassword;

  @override
  List<Object> get props => [password, newPassword];
}
