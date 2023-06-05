// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'privacy_bloc.dart';

abstract class PrivacyEvent extends Equatable {
  const PrivacyEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class NavigationRefreshRequested extends PrivacyEvent {}
