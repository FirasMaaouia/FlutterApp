// To parse this JSON data, do
//
//     final myratings = myratingsFromJson(jsonString);

import 'dart:convert';

List<Myratings> myratingsFromJson(String str) =>
    List<Myratings>.from(json.decode(str).map((x) => Myratings.fromJson(x)));

String myratingsToJson(List<Myratings> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Myratings {
  Myratings({
    this.comments,
    this.ratings,
  });

  List<Comment> comments;
  List<Rating> ratings;

  factory Myratings.fromJson(Map<String, dynamic> json) => Myratings(
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        ratings:
            List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    this.id,
    this.content,
    this.commentedBy,
    this.timeStamp,
  });

  String id;
  String content;
  String commentedBy;
  String timeStamp;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["_id"],
        content: json["content"],
        commentedBy: json["commentedBy"],
        timeStamp: json["timeStamp"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "content": content,
        "commentedBy": commentedBy,
        "timeStamp": timeStamp,
      };
}

class Rating {
  Rating({
    this.id,
    this.value,
    this.ratedBy,
    this.timeStamp,
  });

  String id;
  int value;
  String ratedBy;
  String timeStamp;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["_id"],
        value: json["value"],
        ratedBy: json["ratedBy"],
        timeStamp: json["timeStamp"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "value": value,
        "ratedBy": ratedBy,
        "timeStamp": timeStamp,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
