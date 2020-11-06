import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
//import 'package:json_serializable/builder.dart';
part 'item.g.dart';

@JsonSerializable(explicitToJson: true)
class Item {
  final int id;
  final String itemName;
  final String itemQuantity;
  final String imageUrl;

  Item(
      {this.id,
      @required this.itemName,
      @required this.itemQuantity,
      @required this.imageUrl});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
