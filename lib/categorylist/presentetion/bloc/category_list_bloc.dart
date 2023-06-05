// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xy_mobil_app/allergens/repository/allergens_repository.dart';
import 'package:xy_mobil_app/allergens/repository/model/allergen.dart';
import 'package:xy_mobil_app/authentication/repository/model/user.dart';
import 'package:xy_mobil_app/categorylist/repository/category_list_repository.dart';
import 'package:xy_mobil_app/categorylist/repository/model/category.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/item_tile.dart';
import 'package:xy_mobil_app/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:xy_mobil_app/profiledetails/repository/profile_repository.dart';

part 'category_list_event.dart';
part 'category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  CategoryListBloc({
    required ProfileRepository profileRepository,
    required AllergensRepository allergensRepository,
    required CategoryListRepository categoryListRepository,
    required NavigationBloc appBloc,
  })  : _profileRepository = profileRepository,
        _allergensRepository = allergensRepository,
        _categoryListRepository = categoryListRepository,
        _appBloc = appBloc,
        super(CategoryListState.initial(
            (appBloc.state as CategoryNavigationState).user)) {
    _handleAppState(_appBloc.state);
  }

  final ProfileRepository _profileRepository;
  final AllergensRepository _allergensRepository;
  final CategoryListRepository _categoryListRepository;
  final NavigationBloc _appBloc;
  StreamSubscription? _appBlocSubscription;
  StreamSubscription? _userSettingsSubscription;

  @override
  Stream<CategoryListState> mapEventToState(
    CategoryListEvent event,
  ) async* {
    if (event is NavigationRefreshRequested) {
      yield* _fetchCategoryList();
    } else if (event is ManualRefreshRequested) {
      yield* _fetchCategoryList();
    } else if (event is CategorySelected) {
      yield* _handleCategorySelected(event.category);
    } else if (event is BackButtonPressed) {
      yield* _handleBackButtonPressed();
    } else if (event is LoadMoreRequested) {
      yield* _handleLoadMore();
    }
  }

  Stream<CategoryListState> _fetchCategoryList() async* {
    yield state.copyWith(
      categoryList: const [],
      currentList: const [],
      allergensList: const [],
      itemCount: 0,
    );
    try {
      final User user = await _profileRepository.getUser();
      final categoryList = await _categoryListRepository.mainCategories();
      final List<Allergen> allergensList =
          await _allergensRepository.allergens();
      List allergens = [];
      for (var i = 0; i < allergensList.length; i++) {
        allergens.add({
          "id": allergensList[i].id,
          "name": allergensList[i].name,
          "icon": allergensList[i].icon,
          "active": user.allergies.contains(allergensList[i]),
        });
      }

      yield state.copyWith(
        categoryList: categoryList,
        currentList: categoryList,
        allergensList: allergens,
        itemCount: 0,
      );
    } on Exception catch (error) {
      yield state.copyWith(
        categoryList: const [],
        currentList: const [],
        allergensList: const [],
        itemCount: 0,
      );
    }
  }

  Stream<CategoryListState> _handleCategorySelected(Category category) async* {
    if (category.children.isNotEmpty) {
      yield state.copyWith(
        currentList: category.children,
      );
    } else if (category.children.isEmpty) {
      final categoryList = await _categoryListRepository.items(category.id, 0);
      yield state.copyWith(
        currentList: categoryList,
        itemCount: category.activeItemCount,
      );
    }
  }

  Stream<CategoryListState> _handleBackButtonPressed() async* {
    if (state.categoryList == state.currentList) {
      yield state;
    } else if (state.currentList.isEmpty) {
      yield state.copyWith(
        currentList: state.categoryList,
      );
    } else {
      List<Category> parentList = const [];
      int id = 0;

      if (state.currentList[0].runtimeType == Category) {
        id = (state.currentList[0] as Category).parentId;
      } else if (state.currentList[0].runtimeType == ItemTile) {
        id = (state.currentList[0] as ItemTile).categoryId;
      }
      parentList = getParent(id, state.categoryList);
      yield state.copyWith(
        currentList: parentList,
        itemCount: 0,
      );
    }
  }

  List<Category> getParent(int id, List<Category> list) {
    List<Category> parent = [];
    for (var i = 0; i < list.length; i++) {
      if (list[i].id == id) {
        return list;
      } else {
        parent = getParent(id, list[i].children);
        if (parent.isNotEmpty) {
          return parent;
        }
      }
    }
    return parent;
  }

  Stream<CategoryListState> _handleLoadMore() async* {
    if (state.currentList[0].runtimeType == ItemTile &&
        state.itemCount > state.currentList.length) {
      final moreItemsList = await _categoryListRepository.items(
          (state.currentList[0] as ItemTile).categoryId,
          state.currentList.length);
      state.currentList.addAll(moreItemsList);
      // state.currentList.add(new ItemTile(
      //   id: 99999,
      //   name: "LazyLoad teszt",
      //   categoryId: (state.currentList[0] as ItemTile).categoryId,
      //   votes: 22,
      //   allergens: [],
      // ));
    }
  }

  void _handleAppState(NavigationState appState) {
    if (appState is CategoryNavigationState) {
      add(NavigationRefreshRequested());
    }
  }

  @override
  Future<void> close() {
    _userSettingsSubscription?.cancel();
    _appBlocSubscription?.cancel();
    return super.close();
  }
}
