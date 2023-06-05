// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String? ?? '',
      deleted: json['deleted'] as bool,
      parentId: json['parentId'] as int? ?? 0,
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => ItemTile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      activeItemCount: json['activeItemCount'] as int,
      itemCount: json['itemCount'] as int,
      childCount: json['childCount'] as int,
      hasImage: json['hasImage'] as bool,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'deleted': instance.deleted,
      'parentId': instance.parentId,
      'children': instance.children,
      'items': instance.items,
      'activeItemCount': instance.activeItemCount,
      'itemCount': instance.itemCount,
      'childCount': instance.childCount,
      'hasImage': instance.hasImage,
    };
