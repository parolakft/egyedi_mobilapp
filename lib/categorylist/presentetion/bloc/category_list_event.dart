// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'category_list_bloc.dart';

abstract class CategoryListEvent extends Equatable {
  const CategoryListEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class NavigationRefreshRequested extends CategoryListEvent {}

class ManualRefreshRequested extends CategoryListEvent {}

class LoadMoreRequested extends CategoryListEvent {}

class CategorySelected extends CategoryListEvent {
  const CategorySelected(this.category);

  final Category category;

  @override
  List<Object> get props => [category];
}

class BackButtonPressed extends CategoryListEvent {}
