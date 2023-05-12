import 'package:flutter/material.dart';

class User {
  String id;
  String name;
  String email;
  String username;
  String type;
  String profilepic;
  String chatId;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.username,
    @required this.type,
    @required this.profilepic,
    this.chatId,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    type = json['type'];
    profilepic = json['profilepic'];
    chatId = json['chatId'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'username': username,
      'email': email,
      'type': type,
      'profilepic': profilepic,
    };
  }

  User.fromLocalDatabaseMap(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    type = json['type'];
    profilepic = json['profilepic'];
  }

  Map<String, dynamic> toLocalDatabaseMap() {
    Map<String, dynamic> map = {};
    map['_id'] = id;
    map['name'] = name;
    map['username'] = username;
    map['email'] = email;
    map['type'] = type;
    map['profilepic'] = profilepic;
    return map;
  }

  @override
  String toString() {
    return '{"_id":"$id","name":"$name","username":"$username","email":"$email","type":"$type","profilepic":"$profilepic"}';
  }
}
