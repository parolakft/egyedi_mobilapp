// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/allergen_info.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/nutrition_info.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'item_details.g.dart';

@JsonSerializable()
class ItemDetails extends Equatable {
  final int id;
  // final int parman;
  final String name;
  // final String shortName;
  final String description;
  final double rating;
  final String ingredients;
  // final String subtitle;
  // final bool deleted;
  // final String code;
  final int categoryId;
  final List<AllergenInfo> allergens;
  final List<NutritionInfo> nutritions;
  // final List<Norm> norm;
  // final List groups;
  final int votes;
  // final bool hasImage;

  const ItemDetails({
    required this.id,
    // required this.parman,
    required this.name,
    // this.shortName = '',
    required this.description,
    required this.rating,
    required this.ingredients,
    // this.subtitle = '',
    // required this.deleted,
    // required this.code,
    this.allergens = const [],
    this.nutritions = const [],
    // required this.norm,
    // this.groups = const [],
    required this.categoryId,
    required this.votes,
    // required this.hasImage,
  });

  const ItemDetails.empty()
      : id = 0,
        // parman = 0,
        name = '',
        // shortName = '',
        description = '',
        rating = 0.0,
        ingredients = '',
        // subtitle = '',
        // deleted = false,
        // code = '',
        allergens = const [],
        nutritions = const [],
        // norm = const [],
        // groups = const [],
        categoryId = 0,
        votes = 0;
  // hasImage = false;

  factory ItemDetails.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDetailsToJson(this);

  bool get isEmpty =>
      id == 0 &&
      // parman == 0 &&
      name.isEmpty &&
      // shortName.isEmpty &&
      description.isEmpty &&
      rating == 0.0 &&
      ingredients.isEmpty &&
      // subtitle.isEmpty &&
      // deleted == false &&
      // code.isEmpty &&
      allergens.isEmpty &&
      nutritions.isEmpty &&
      // norm.isEmpty &&
      // groups.isEmpty &&
      categoryId == 0 &&
      votes == 0;
  //  && hasImage == false;

  @override
  List<Object> get props => [
        id,
        // parman,
        name,
        // shortName,
        // description,
        // rating,
        // ingredients,
        // subtitle,
        // deleted,
        // code,
        allergens,
        // nutritions,
        // norm,
        // groups,
        categoryId,
        votes,
        // hasImage
      ];

  @override
  bool get stringify => true;
}
