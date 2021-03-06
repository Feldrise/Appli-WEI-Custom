import 'package:flutter/material.dart';

class Challenge {
  String id;

  String name;
  String description;
  int value;

  ImageProvider<dynamic> image;
  String imageId;

  bool isWaitingValidation = false;
  int numberLeft;

  final bool isForTeam;

  Challenge.fromMap(Map<String, dynamic> map, {this.isForTeam = false}) :
    id = map['id'] as String,
    imageId = map['imageId'] as String,
    name = map['name'] as String,
    description = map['description'] as String,
    value = map['value'] as int,
    numberLeft = map['numberLeft'] as int  {
      if (!isForTeam) {
        isWaitingValidation = map['waitingValidation'] as bool;
      }
    }
}