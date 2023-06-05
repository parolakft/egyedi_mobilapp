// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'vote_bloc.dart';

class VoteState extends Equatable {
  const VoteState({
    required this.voteId,
    required this.voteDetailedList,
  });

  final int voteId;
  final List<VoteDetail> voteDetailedList;

  const VoteState.initial()
      : voteId = 0,
        voteDetailedList = const [];

  VoteState copyWith({
    int? voteId,
    List<VoteDetail>? voteDetailedList,
  }) {
    return VoteState(
      voteId: voteId ?? this.voteId,
      voteDetailedList: voteDetailedList ?? this.voteDetailedList,
    );
  }

  @override
  List<Object> get props => [voteId, voteDetailedList];

  @override
  String toString() {
    return '$runtimeType(${voteId.toString()}, ${voteDetailedList.toString()})';
  }
}
