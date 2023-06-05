// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xy_mobil_app/voting/repository/model/vote_detail.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'vote_detailed_list_data.g.dart';

@JsonSerializable()
class VoteDetailedListData extends Equatable {
  final String status;
  final List<VoteDetail> list;

  const VoteDetailedListData({
    required this.status,
    required this.list,
  });

  const VoteDetailedListData.empty()
      : status = '',
        list = const [];

  factory VoteDetailedListData.fromJson(Map<String, dynamic> json) =>
      _$VoteDetailedListDataFromJson(json);

  Map<String, dynamic> toJson() => _$VoteDetailedListDataToJson(this);

  bool get isEmpty => status.isEmpty && list.isEmpty;

  @override
  List<Object> get props => [status, list];

  @override
  bool get stringify => true;
}
