// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetails _$ItemDetailsFromJson(Map<String, dynamic> json) => ItemDetails(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      rating: (json['rating'] as num).toDouble(),
      ingredients: json['ingredients'] as String,
      allergens: (json['allergens'] as List<dynamic>?)
              ?.map((e) => AllergenInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      nutritions: (json['nutritions'] as List<dynamic>?)
              ?.map((e) => NutritionInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      categoryId: json['categoryId'] as int,
      votes: json['votes'] as int,
    );

Map<String, dynamic> _$ItemDetailsToJson(ItemDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'rating': instance.rating,
      'ingredients': instance.ingredients,
      'categoryId': instance.categoryId,
      'allergens': instance.allergens,
      'nutritions': instance.nutritions,
      'votes': instance.votes,
    };
