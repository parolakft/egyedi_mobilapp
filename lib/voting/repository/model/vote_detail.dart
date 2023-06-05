// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'vote_detail.g.dart';

@JsonSerializable()
class VoteDetail extends Equatable {
  final int id;
  final String detail;
  final bool active;
  final String defaultValue;
  final int order;

  const VoteDetail({
    required this.id,
    required this.detail,
    required this.active,
    required this.defaultValue,
    this.order = 0,
  });

  const VoteDetail.empty()
      : id = 0,
        detail = '',
        active = true,
        defaultValue = '',
        order = 0;

  factory VoteDetail.fromJson(Map<String, dynamic> json) =>
      _$VoteDetailFromJson(json);

  Map<String, dynamic> toJson() => _$VoteDetailToJson(this);

  bool get isEmpty =>
      id == 0 &&
      detail.isEmpty &&
      active == true &&
      defaultValue.isEmpty &&
      order == 0;

  @override
  List<Object> get props => [id, detail, active, defaultValue, order];

  @override
  bool get stringify => true;
}
