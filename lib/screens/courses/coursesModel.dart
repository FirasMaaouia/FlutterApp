// To parse this JSON data, do
//
//     final courseList = courseListFromJson(jsonString);

import 'dart:convert';

List<CourseList> courseListFromJson(String str) =>
    List<CourseList>.from(json.decode(str).map((x) => CourseList.fromJson(x)));

String courseListToJson(List<CourseList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseList {
  CourseList({
    this.ratingAvg,
    this.id,
    this.date,
    this.usermail,
    this.title,
    this.fullname,
    this.description,
    this.available,
    this.basicprice,
    this.basicdescription,
    this.basichours,
    this.standardprice,
    this.standarddesc,
    this.standardhours,
    this.premiumprice,
    this.premiumdesc,
    this.premiumhours,
    this.ratings,
    this.comments,
    this.coupon,
    this.v,
    this.image,
    this.time,
    this.category,
    this.basicdesc,
    this.link,
    this.rating,
    this.imagepath,
  });

  double ratingAvg;
  String id;
  String date;
  String usermail;
  String title;
  String fullname;
  String description;
  String available;
  String basicprice;
  String basicdescription;
  String basichours;
  String standardprice;
  String standarddesc;
  String standardhours;
  String premiumprice;
  String premiumdesc;
  String premiumhours;
  List<Rating> ratings;
  List<Comment> comments;
  List<Coupon> coupon;
  int v;
  String image;
  String time;
  String category;
  String basicdesc;
  String link;
  String rating;
  String imagepath;

  factory CourseList.fromJson(Map<String, dynamic> json) => CourseList(
        ratingAvg: json["ratingAvg"].toDouble(),
        id: json["_id"],
        date: json["date"],
        usermail: json["usermail"],
        title: json["title"],
        fullname: json["fullname"],
        description: json["description"],
        available: json["available"],
        basicprice: json["basicprice"],
        basicdescription: json["basicdescription"],
        basichours: json["basichours"],
        standardprice: json["standardprice"],
        standarddesc: json["standarddesc"],
        standardhours: json["standardhours"],
        premiumprice: json["premiumprice"],
        premiumdesc: json["premiumdesc"],
        premiumhours: json["premiumhours"],
        ratings:
            List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        coupon:
            List<Coupon>.from(json["coupon"].map((x) => Coupon.fromJson(x))),
        v: json["__v"],
        image: json["image"],
        time: json["time"],
        category: json["category"],
        basicdesc: json["basicdesc"],
        link: json["link"],
        rating: json["rating"],
        imagepath: json["imagepath"],
      );

  Map<String, dynamic> toJson() => {
        "ratingAvg": ratingAvg,
        "_id": id,
        "date": date,
        "usermail": usermail,
        "title": title,
        "fullname": fullname,
        "description": description,
        "available": available,
        "basicprice": basicprice,
        "basicdescription": basicdescription,
        "basichours": basichours,
        "standardprice": standardprice,
        "standarddesc": standarddesc,
        "standardhours": standardhours,
        "premiumprice": premiumprice,
        "premiumdesc": premiumdesc,
        "premiumhours": premiumhours,
        "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "coupon": List<dynamic>.from(coupon.map((x) => x.toJson())),
        "__v": v,
        "image": image,
        "time": time,
        "category": category,
        "basicdesc": basicdesc,
        "link": link,
        "rating": rating,
        "imagepath": imagepath,
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

class Coupon {
  Coupon({
    this.code,
    this.id,
    this.user,
    this.course,
  });

  String code;
  String id;
  String user;
  String course;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        code: json["code"],
        id: json["_id"],
        user: json["user"],
        course: json["course"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "_id": id,
        "user": user,
        "course": course,
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
