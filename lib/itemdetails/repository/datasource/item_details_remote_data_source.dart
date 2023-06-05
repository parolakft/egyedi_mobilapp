// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:xy_mobil_app/core/xy_api_client.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/item_detail_data.dart';

class ItemDetailsRemoteDataSource {
  ItemDetailsRemoteDataSource({
    required XYApiClient apiClient,
  }) : _apiClient = apiClient;

  final XYApiClient _apiClient;

  Future<ItemDetailsData> itemDetails(int itemId) async {
    var itemDetailsData = ItemDetailsData.fromJson(await _apiClient
        .callApi('mobile/itemDetails', parameters: {'id': itemId}));
    return itemDetailsData;
  }
}
