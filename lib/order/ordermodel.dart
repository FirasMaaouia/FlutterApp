import 'dart:convert';

class Lesson {
  String title;
  String level;
  double indicatorValue;
  int price;
  String content;

  Lesson(
      {this.title, this.level, this.indicatorValue, this.price, this.content});
}

// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order({
    this.id,
    this.sendermail,
    this.sendername,
    this.senderusername,
    this.senderpackage,
    this.courseemail,
    this.startdate,
    this.starttime,
    this.token,
    this.date,
    this.time,
    this.coursetitle,
    this.orderstatus,
    this.teacherstatus,
    this.totalprice,
    this.v,
  });

  String id;
  String sendermail;
  String sendername;
  String senderusername;
  String senderpackage;
  String courseemail;
  String startdate;
  String starttime;
  String token;
  String date;
  String time;
  String coursetitle;
  String orderstatus;
  String teacherstatus;
  String totalprice;
  int v;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["_id"],
        sendermail: json["sendermail"],
        sendername: json["sendername"],
        senderusername: json["senderusername"],
        senderpackage: json["senderpackage"],
        courseemail: json["courseemail"],
        startdate: json["startdate"],
        starttime: json["starttime"],
        token: json["token"],
        date: json["date"],
        time: json["time"],
        coursetitle: json["coursetitle"],
        orderstatus: json["orderstatus"],
        teacherstatus: json["teacherstatus"],
        totalprice: json["totalprice"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sendermail": sendermail,
        "sendername": sendername,
        "senderusername": senderusername,
        "senderpackage": senderpackage,
        "courseemail": courseemail,
        "startdate": startdate,
        "starttime": starttime,
        "token": token,
        "date": date,
        "time": time,
        "coursetitle": coursetitle,
        "orderstatus": orderstatus,
        "teacherstatus": teacherstatus,
        "totalprice": totalprice,
        "__v": v,
      };
}
