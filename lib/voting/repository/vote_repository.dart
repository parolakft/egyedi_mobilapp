// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:xy_mobil_app/voting/repository/datasource/vote_remote_date_source.dart';
import 'package:xy_mobil_app/voting/repository/model/see_data.dart';
import 'package:xy_mobil_app/voting/repository/model/vote_detail.dart';
import 'package:xy_mobil_app/voting/repository/model/vote_detailed_list_data.dart';

class VoteRepository {
  VoteRepository({
    required VoteRemoteDataSource voteRemoteDataSource,
  }) : _voteRemoteDataSource = voteRemoteDataSource;

  final VoteRemoteDataSource _voteRemoteDataSource;

  Future<int> see(int itemId) async {
    SeeData seeData = await _voteRemoteDataSource.see(itemId);
    return seeData.data;
  }

  Future<void> vote(int voteId, String value) async {
    await _voteRemoteDataSource.vote(voteId, value);
  }

  Future<void> voteDetailed(int voteId, int detailId, String value) async {
    await _voteRemoteDataSource.voteDetailed(voteId, detailId, value);
  }

  Future<List<VoteDetail>> getDetails() async {
    VoteDetailedListData voteDetailedListData =
        await _voteRemoteDataSource.getDetails();
    return voteDetailedListData.list;
  }
}
