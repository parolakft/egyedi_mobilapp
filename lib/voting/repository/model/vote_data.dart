// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'vote_data.g.dart';

@JsonSerializable()
class VoteData extends Equatable {
  final String status;
  final String messages;

  const VoteData({
    required this.status,
    this.messages = '',
  });

  const VoteData.empty()
      : status = '',
        messages = '';

  factory VoteData.fromJson(Map<String, dynamic> json) =>
      _$VoteDataFromJson(json);

  Map<String, dynamic> toJson() => _$VoteDataToJson(this);

  bool get isEmpty => status.isEmpty && messages.isEmpty;

  @override
  List<Object> get props => [status, messages];

  @override
  bool get stringify => true;
}
