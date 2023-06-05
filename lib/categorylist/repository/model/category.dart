// ------------------------------------
// ------------ Parola Kft ------------
// ---------- info@parola.hu ----------
// ------------------------------------

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xy_mobil_app/itemdetails/repository/model/item_tile.dart';

/*

  flutter packages pub run build_runner build --delete-conflicting-outputs --delete-conflicting-outputs

 */
part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable {
  final int id;
  final String name;
  final String image;
  final bool deleted;
  final int parentId;
  final List<Category> children;
  final List<ItemTile> items;
  final int activeItemCount;
  final int itemCount;
  final int childCount;
  final bool hasImage;

  const Category({
    required this.id,
    required this.name,
    this.image = '',
    required this.deleted,
    this.parentId = 0,
    this.children = const [],
    this.items = const [],
    required this.activeItemCount,
    required this.itemCount,
    required this.childCount,
    required this.hasImage,
  });

  const Category.empty()
      : id = 0,
        name = '',
        image = '',
        deleted = false,
        parentId = 0,
        children = const [],
        items = const [],
        activeItemCount = 0,
        itemCount = 0,
        childCount = 0,
        hasImage = false;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  bool get isEmpty =>
      id == 0 &&
      name.isEmpty &&
      image.isEmpty &&
      deleted == false &&
      parentId == 0 &&
      children.isEmpty &&
      items.isEmpty &&
      activeItemCount == 0 &&
      itemCount == 0 &&
      childCount == 0 &&
      hasImage == false;

  @override
  List<Object> get props => [
        id,
        name,
        image,
        deleted,
        parentId,
        children,
        items,
        activeItemCount,
        itemCount,
        childCount,
        hasImage
      ];

  @override
  bool get stringify => true;
}
