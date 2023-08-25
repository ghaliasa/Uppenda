import 'package:flutter/material.dart';

class ReactionModel {
  String id;
  String reactionType;
  String colorName;

  Color color;

  ReactionModel({this.id, this.reactionType, this.colorName}) {
    this.color = Color(int.parse(this.colorName));
  }

  ReactionModel.fromJson(Map<String, dynamic> json) {
    this.id = json["id"].toString();
    this.reactionType = json["reactionType"];
    this.colorName = json["colorName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['colorName'] = this.colorName;
    data['reactionType'] = this.reactionType;
    return data;
  }

  String get getColorName => this.colorName;

  set setColorName(String colorName) => this.colorName = colorName;
  String getId() {
    return id;
  }

  Color getColor() {
    return this.color;
  }

  String getName() {
    return reactionType;
  }
}
