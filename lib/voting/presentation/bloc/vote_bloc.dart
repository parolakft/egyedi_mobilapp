// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/item_tile.dart';
import 'package:xy_mobil_app/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:xy_mobil_app/voting/repository/model/vote_detail.dart';
import 'package:xy_mobil_app/voting/repository/vote_repository.dart';

part 'vote_event.dart';
part 'vote_state.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {
  VoteBloc({
    required VoteRepository voteRepository,
    required NavigationBloc appBloc,
  })  : _voteRepository = voteRepository,
        _appBloc = appBloc,
        super(const VoteState.initial()) {
    _handleAppState(_appBloc.state);
  }

  final VoteRepository _voteRepository;
  final NavigationBloc _appBloc;
  StreamSubscription? _appBlocSubscription;
  StreamSubscription? _userSettingsSubscription;

  @override
  Stream<VoteState> mapEventToState(
    VoteEvent event,
  ) async* {
    if (event is NavigationRefreshRequested) {
      yield* _fetchItem(event.item);
    } else if (event is DoVote) {
      yield* _vote(event.id, event.value);
    }
  }

  Stream<VoteState> _fetchItem(ItemTile item) async* {
    yield state.copyWith(
      voteId: 0,
    );
    try {
      final voteId = await _voteRepository.see(item.id);
      final voteDetailedList = await _voteRepository.getDetails();

      yield state.copyWith(
        voteId: voteId,
        voteDetailedList: voteDetailedList,
      );
    } on Exception catch (error) {
      yield state.copyWith(
        voteId: 0,
      );
    }
  }

  Stream<VoteState> _vote(int id, String value) async* {
    try {
      if (id == 0) {
        await _voteRepository.vote(state.voteId, value);
      } else {
        await _voteRepository.voteDetailed(state.voteId, id, value);
      }

      yield state;
    } on Exception catch (error) {
      yield state;
    }
  }

  void _handleAppState(NavigationState appState) {
    if (appState is ItemDetailsNavigationState) {
      add(NavigationRefreshRequested(appState.item));
    }
  }

  @override
  Future<void> close() {
    _userSettingsSubscription?.cancel();
    _appBlocSubscription?.cancel();
    return super.close();
  }
}
