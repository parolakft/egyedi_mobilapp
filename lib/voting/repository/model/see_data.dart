// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'see_data.g.dart';

@JsonSerializable()
class SeeData extends Equatable {
  final String status;
  final int data;

  const SeeData({
    required this.status,
    required this.data,
  });

  const SeeData.empty()
      : status = '',
        data = 0;

  factory SeeData.fromJson(Map<String, dynamic> json) =>
      _$SeeDataFromJson(json);

  Map<String, dynamic> toJson() => _$SeeDataToJson(this);

  bool get isEmpty => status.isEmpty && data == 0;

  @override
  List<Object> get props => [status, data];

  @override
  bool get stringify => true;
}
