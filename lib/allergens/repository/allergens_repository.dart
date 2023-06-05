// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'dart:async';

import 'package:xy_mobil_app/allergens/repository/datasource/allergens_remote_data_source.dart';
import 'package:xy_mobil_app/allergens/repository/model/allergen.dart';
import 'package:xy_mobil_app/allergens/repository/model/allergens_data.dart';

class AllergensRepository {
  AllergensRepository({
    required AllergensRemoteDataSource allergensRemoteDataSource,
  }) : _allergensRemoteDataSource = allergensRemoteDataSource;

  final AllergensRemoteDataSource _allergensRemoteDataSource;

  Future<List<Allergen>> allergens() async {
    AllergensData allergensData = await _allergensRemoteDataSource.allergens();
    return allergensData.list;
  }
}
