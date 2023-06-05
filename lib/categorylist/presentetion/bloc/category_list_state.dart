// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

part of 'category_list_bloc.dart';

class CategoryListState extends Equatable {
  const CategoryListState({
    required this.user,
    required this.categoryList,
    required this.currentList,
    required this.allergensList,
    required this.itemCount,
  });

  final User user;
  final List<Category> categoryList;
  final List currentList;
  final List allergensList;
  final int itemCount;

  const CategoryListState.initial(this.user)
      : categoryList = const [],
        currentList = const [],
        allergensList = const [],
        itemCount = 0;

  CategoryListState copyWith({
    User? user,
    List<Category>? categoryList,
    List? currentList,
    List? allergensList,
    int? itemCount,
  }) {
    return CategoryListState(
      user: user ?? this.user,
      categoryList: categoryList ?? this.categoryList,
      currentList: currentList ?? this.currentList,
      allergensList: allergensList ?? this.allergensList,
      itemCount: itemCount ?? this.itemCount,
    );
  }

  @override
  List<Object> get props =>
      [user, categoryList, currentList, allergensList, itemCount];

  @override
  String toString() {
    return '$runtimeType(${user.toString()}, ${categoryList.toString()}, ${currentList.toString()}, ${allergensList.toString()}, ${itemCount.toString()})';
  }
}
