// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grocery _$GroceryFromJson(Map<String, dynamic> json) {
  return Grocery(
    id: json['id'] as String,
    groceryShopName: json['groceryShopName'] as String,
    dateTime: json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String),
    items: (json['items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GroceryToJson(Grocery instance) => <String, dynamic>{
      'id': instance.id,
      'groceryShopName': instance.groceryShopName,
      'dateTime': instance.dateTime?.toIso8601String(),
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
    };
