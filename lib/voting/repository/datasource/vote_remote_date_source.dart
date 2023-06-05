// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:xy_mobil_app/core/xy_api_client.dart';
import 'package:xy_mobil_app/voting/repository/model/see_data.dart';
import 'package:xy_mobil_app/voting/repository/model/vote_data.dart';
import 'package:xy_mobil_app/voting/repository/model/vote_detailed_list_data.dart';

class VoteRemoteDataSource {
  VoteRemoteDataSource({
    required XYApiClient apiClient,
  }) : _apiClient = apiClient;

  final XYApiClient _apiClient;

  Future<SeeData> see(int itemId) async {
    var seeData = SeeData.fromJson(
        await _apiClient.callApi('mobile/see', parameters: {'id': itemId}));
    return seeData;
  }

  Future<VoteData> vote(int voteId, String value) async {
    var voteData = VoteData.fromJson(await _apiClient
        .callApi('mobile/vote', parameters: {'id': voteId, 'value': value}));
    return voteData;
  }

  Future<VoteData> voteDetailed(int voteId, int detailId, String value) async {
    var voteData = VoteData.fromJson(await _apiClient.callApi(
        'mobile/voteDetailed',
        parameters: {'id': voteId, 'detail': detailId, 'value': value}));
    return voteData;
  }

  Future<VoteDetailedListData> getDetails() async {
    var voteDetails = VoteDetailedListData.fromJson(
        await _apiClient.callApi('mobile/voteDetails'));
    return voteDetails;
  }
}
