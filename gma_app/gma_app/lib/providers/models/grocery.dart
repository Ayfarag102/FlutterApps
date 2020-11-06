import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
//import 'package:json_serializable/builder.dart';
import './item.dart';
part 'grocery.g.dart';

@JsonSerializable(explicitToJson: true)
class Grocery {
  final String id;
  final String groceryShopName;
  final DateTime dateTime;
  final List<Item> items;

  Grocery({
    @required this.id,
    @required this.groceryShopName,
    @required this.dateTime,
    @required this.items,
  });

  factory Grocery.fromJson(Map<String, dynamic> json) =>
      _$GroceryFromJson(json);

  Map<String, dynamic> toJson() => _$GroceryToJson(this);
}
