// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:xy_mobil_app/categorylist/repository/model/categories_data.dart';
import 'package:xy_mobil_app/categorylist/repository/model/category.dart';
import 'package:xy_mobil_app/categorylist/repository/model/items_data.dart';
import 'package:xy_mobil_app/core/xy_api_client.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/item_tile.dart';

class CategoriesRemoteDataSource {
  CategoriesRemoteDataSource({
    required XYApiClient apiClient,
  }) : _apiClient = apiClient;

  final XYApiClient _apiClient;

  Future<List<Category>> mainCategories() async {
    List<Category> categoryList = CategoriesData.fromJson(
            await _apiClient.callApi('mobile/mainCategories'))
        .list;
    return categoryList;
  }

  Future<List<ItemTile>> items(int id, int offset) async {
    List<ItemTile> categoryList = ItemsData.fromJson(await _apiClient.callApi(
            'mobile/items',
            parameters: {'id': id, 'offset': offset, 'limit': 10}))
        .list;
    return categoryList;
  }
}
