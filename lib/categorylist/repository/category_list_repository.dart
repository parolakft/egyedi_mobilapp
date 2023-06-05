// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:xy_mobil_app/categorylist/repository/datasource/categories_remote_data_source.dart';
import 'package:xy_mobil_app/categorylist/repository/model/category.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/item_tile.dart';

class CategoryListRepository {
  CategoryListRepository({
    required CategoriesRemoteDataSource categoriesRemoteDataSource,
  }) : _categoriesRemoteDataSource = categoriesRemoteDataSource;

  final CategoriesRemoteDataSource _categoriesRemoteDataSource;

  Future<List<Category>> mainCategories() async {
    return await _categoriesRemoteDataSource.mainCategories();
  }

  Future<List<ItemTile>> items(int id, int offset) async {
    return await _categoriesRemoteDataSource.items(id, offset);
  }
}
