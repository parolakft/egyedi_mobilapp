// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'allergens_bloc.dart';

abstract class AllergensEvent extends Equatable {
  const AllergensEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class NavigationRefreshRequested extends AllergensEvent {}
