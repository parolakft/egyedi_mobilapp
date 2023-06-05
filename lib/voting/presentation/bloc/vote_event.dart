// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'vote_bloc.dart';

abstract class VoteEvent extends Equatable {
  const VoteEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class NavigationRefreshRequested extends VoteEvent {
  const NavigationRefreshRequested(this.item);

  final ItemTile item;

  @override
  List<Object> get props => [item];
}

class DoVote extends VoteEvent {
  const DoVote(this.id, this.value);

  final int id;
  final String value;

  @override
  List<Object> get props => [id, value];
}
