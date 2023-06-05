// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:xy_mobil_app/itemdetails/repository/datasource/item_details_remote_data_source.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/item_detail_data.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/item_details.dart';

class ItemDetailsRepository {
  ItemDetailsRepository({
    required ItemDetailsRemoteDataSource itemDetailsRemoteDataSource,
  }) : _itemDetailsRemoteDataSource = itemDetailsRemoteDataSource;

  final ItemDetailsRemoteDataSource _itemDetailsRemoteDataSource;

  Future<ItemDetails> itemDetails(int itemId) async {
    ItemDetailsData itemDetailsData =
        await _itemDetailsRemoteDataSource.itemDetails(itemId);
    return itemDetailsData.data;
  }
}
