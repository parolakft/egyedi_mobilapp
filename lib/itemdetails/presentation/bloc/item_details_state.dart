// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'item_details_bloc.dart';

class ItemDetailsState extends Equatable {
  const ItemDetailsState({
    required this.item,
  });

  final ItemDetails item;

  const ItemDetailsState.initial() : item = const ItemDetails.empty();

  ItemDetailsState copyWith({ItemDetails? item}) {
    return ItemDetailsState(
      item: item ?? this.item,
    );
  }

  @override
  List<Object> get props => [item];

  @override
  String toString() {
    return '$runtimeType(${item.toString()})';
  }
}
