// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'info_data.g.dart';

@JsonSerializable()
class InfoData extends Equatable {
  final String status;
  final String data;

  const InfoData({
    required this.status,
    required this.data,
  });

  const InfoData.empty()
      : status = '',
        data = '';

  factory InfoData.fromJson(Map<String, dynamic> json) =>
      _$InfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$InfoDataToJson(this);

  bool get isEmpty => status.isEmpty && data.isEmpty;

  @override
  List<Object> get props => [status, data];

  @override
  bool get stringify => true;
}
