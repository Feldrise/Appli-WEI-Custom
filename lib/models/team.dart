import 'dart:convert';

import 'package:flutter/material.dart';

class Team {
  String id;

  MemoryImage image;
  String imageId;

  String name;
  String captainId;
  String captainName;
  int score;

  List<String> members;

  Team() : 
    name = "",
    captainName = "",
    score = 0;

  Team.fromMap(Map<String, dynamic> map) :
    id = map['id'] as String,
    imageId = map['imageId'] as String,
    name = map['name'] as String,
    captainId = map['captainId'] as String,
    captainName = map['captainName'] as String,
    score = map['score'] as int,
    members = List<String>.from(map['members'] as List<dynamic>);
  
  String toJson() => jsonEncode(<String, dynamic>{
    "id": id,
    "imageId": imageId,
    "image": image != null ? base64Encode(image.bytes) : null,
    "name": name,
    "captainId": captainId,
    "score": score
  });
}