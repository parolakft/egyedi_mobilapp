// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'allergens_bloc.dart';

class AllergensState extends Equatable {
  const AllergensState({
    required this.allergensList,
  });

  final List<Allergen> allergensList;

  const AllergensState.initial() : allergensList = const [];

  AllergensState copyWith({
    List<Allergen>? allergensList,
  }) {
    return AllergensState(
      allergensList: allergensList ?? const [],
    );
  }

  @override
  List<Object> get props => [allergensList];

  @override
  String toString() {
    return '$runtimeType(${allergensList.toString()})';
  }
}
