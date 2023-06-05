// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'item_details_bloc.dart';

abstract class ItemDetailsEvent extends Equatable {
  const ItemDetailsEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class NavigationRefreshRequested extends ItemDetailsEvent {
  const NavigationRefreshRequested(this.item);

  final ItemTile item;

  @override
  List<Object> get props => [item];
}
