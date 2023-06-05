// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_tile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemTile _$ItemTileFromJson(Map<String, dynamic> json) => ItemTile(
      id: json['id'] as int,
      name: json['name'] as String,
      allergens: (json['allergens'] as List<dynamic>?)
              ?.map((e) => AllergenInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      categoryId: json['categoryId'] as int,
      votes: json['votes'] as int,
    );

Map<String, dynamic> _$ItemTileToJson(ItemTile instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categoryId': instance.categoryId,
      'allergens': instance.allergens,
      'votes': instance.votes,
    };
