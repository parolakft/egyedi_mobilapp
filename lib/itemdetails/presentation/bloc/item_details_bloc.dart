// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xy_mobil_app/itemdetails/repository/item_details_repository.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/item_details.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/item_tile.dart';
import 'package:xy_mobil_app/navigation/presentation/bloc/navigation_bloc.dart';

part 'item_details_event.dart';
part 'item_details_state.dart';

class ItemDetailsBloc extends Bloc<ItemDetailsEvent, ItemDetailsState> {
  ItemDetailsBloc({
    required ItemDetailsRepository itemDetailsRepository,
    required NavigationBloc appBloc,
  })  : _itemDetailsRepository = itemDetailsRepository,
        _appBloc = appBloc,
        super(const ItemDetailsState.initial()) {
    _handleAppState(_appBloc.state);
  }

  final ItemDetailsRepository _itemDetailsRepository;
  final NavigationBloc _appBloc;
  StreamSubscription? _appBlocSubscription;
  StreamSubscription? _userSettingsSubscription;

  @override
  Stream<ItemDetailsState> mapEventToState(
    ItemDetailsEvent event,
  ) async* {
    if (event is NavigationRefreshRequested) {
      yield* _fetchItem(event.item);
    }
  }

  Stream<ItemDetailsState> _fetchItem(ItemTile item) async* {
    yield state.copyWith(
      item: const ItemDetails.empty(),
    );
    try {
      final itemDetails = await _itemDetailsRepository.itemDetails(item.id);

      yield state.copyWith(
        item: itemDetails,
      );
    } on Exception catch (error) {
      yield state.copyWith(
        item: const ItemDetails.empty(),
      );
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
