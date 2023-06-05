// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ApplicationOpened extends NavigationEvent {}

class PagePopped extends NavigationEvent {}

class UserChanged extends NavigationEvent {
  final User user;

  const UserChanged(this.user);

  @override
  List<Object> get props => [user];
}

class ForgottenPwRequested extends NavigationEvent {}

class RegistrationRequested extends NavigationEvent {}

class ProfileRequested extends NavigationEvent {}

class CategoryRequested extends NavigationEvent {}

class ItemDetailsRequested extends NavigationEvent {
  const ItemDetailsRequested(this.item);

  final ItemTile item;

  @override
  List<Object> get props => [item];
}
