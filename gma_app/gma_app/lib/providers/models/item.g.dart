// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    id: json['id'] as int,
    itemName: json['itemName'] as String,
    itemQuantity: json['itemQuantity'] as String,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'itemName': instance.itemName,
      'itemQuantity': instance.itemQuantity,
      'imageUrl': instance.imageUrl,
    };
