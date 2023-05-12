import 'package:flutter/material.dart';
import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/SizeConfig.dart';
import 'package:esprit/static.dart';
import 'package:esprit/order/paymentscreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:esprit/src/utils/my_urls.dart';

class PaymentMethods extends StatefulWidget {
  @override
  _PaymentMethodsState createState() => _PaymentMethodsState();
}

Future<void> createLink() async {
  var uri = Uri.parse("https://sandbox.paymee.tn/api/v1/payments/create");

  var request = new http.MultipartRequest("POST", uri);
  request.headers["Authorization"] =
      "Token ccc3751ae3ae852090a13b51e7b45f3bdbfcfe24";
  request.fields['vendor'] = "1707";
  request.fields['amount'] = CourseOrder.finalprice;
  request.fields['note'] =
      CourseOrder.title + " - " + CourseOrder.chosenpackage;

  // send
  var response = await request.send();
  print(response.statusCode);

  // listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    print(value.toString());
    CourseOrder.token = value.toString().substring(62, 94);
  });
}

class _PaymentMethodsState extends State<PaymentMethods> {
  @override
  void initState() {
    getprice();
    createLink();
    getUserBalance();
    super.initState();
  }

  String chosen = CourseOrder.chosenpackage;

  int finalprice;

  void getprice() {
    if (chosen == "Basic Plan") {
      finalprice = int.parse(CourseOrder.bprice);
    } else if (chosen == "Standard Plan") {
      finalprice = int.parse(CourseOrder.sprice);
    } else {
      finalprice = int.parse(CourseOrder.pprice);
    }
    CourseOrder.finalprice = finalprice.toString();
  }

  static Future<void> getUserBalance() async {
    var url = Uri.parse("${MyUrls.serverUrl}/getuserType");
    String one;
    String two;

    Map data = {'email': CourseOrder.coursemail};
    var body = json.encode(data);

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    String jsonsDataString = response.body.toString();
    // toString of Response's body is assigned to jsonDataString
    data = jsonDecode(jsonsDataString);

    one =
        jsonsDataString.substring(0, jsonsDataString.toString().indexOf(']}'));

    two = one.substring(9);

    Map<String, dynamic> datax = jsonDecode(two);
    Math.balance = datax['balance'];
    Math.newbalance = Math.balance + int.parse(CourseOrder.finalprice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Choose payment method'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Your order summary:",
                style: TextStyle(
                    fontFamily: "muli",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 2.8 * SizeConfig1.textMultiplier,
                    color: AppThemeColors.darkBlue)),
            SizedBox(height: 15),
            Row(children: [
              Text(" Course Title:  ",
                  style: TextStyle(
                      fontFamily: "muli",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                      fontSize: 2.1 * SizeConfig1.textMultiplier,
                      color: AppThemeColors.darkBlue)),
              Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text("${CourseOrder.title}",
                          style: TextStyle(
                              fontFamily: "muli",
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                              fontSize: 2 * SizeConfig1.textMultiplier,
                              color: AppThemeColors.pureBlack)),
                    ),
                  ],
                ),
              ),
            ]),
            SizedBox(height: 10),
            Row(children: [
              Text(" Selected Package:  ",
                  style: TextStyle(
                      fontFamily: "muli",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                      fontSize: 2.1 * SizeConfig1.textMultiplier,
                      color: AppThemeColors.darkBlue)),
              Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 3.0),
                      child: new Text("${CourseOrder.chosenpackage}",
                          style: TextStyle(
                              fontFamily: "muli",
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                              fontSize: 2 * SizeConfig1.textMultiplier,
                              color: AppThemeColors.pureBlack)),
                    ),
                  ],
                ),
              ),
            ]),
            SizedBox(height: 10),
            Row(children: [
              Text(" Start date: ",
                  style: TextStyle(
                      fontFamily: "muli",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                      fontSize: 2.1 * SizeConfig1.textMultiplier,
                      color: AppThemeColors.darkBlue)),
              Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 3.0),
                      child: new Text(
                          "${CourseOrder.startdate} at ${CourseOrder.starttime}",
                          style: TextStyle(
                              fontFamily: "muli",
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                              fontSize: 2 * SizeConfig1.textMultiplier,
                              color: AppThemeColors.pureBlack)),
                    ),
                  ],
                ),
              ),
            ]),
            SizedBox(height: 10),
            Row(children: [
              Text(" Total Price:  ",
                  style: TextStyle(
                      fontFamily: "muli",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                      fontSize: 2.1 * SizeConfig1.textMultiplier,
                      color: AppThemeColors.darkBlue)),
              Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      child: new Text("${CourseOrder.finalprice} TND",
                          style: TextStyle(
                              fontFamily: "muli",
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                              fontSize: 2 * SizeConfig1.textMultiplier,
                              color: AppThemeColors.pureBlack)),
                    ),
                  ],
                ),
              ),
            ]),
            SizedBox(height: 35),
            Text("Available payment methods:",
                style: TextStyle(
                    fontFamily: "muli",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 2.8 * SizeConfig1.textMultiplier,
                    color: AppThemeColors.darkBlue)),
            SizedBox(height: 40),
            Material(
                child: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Paymee()));
              },
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset('assets/images/paypal.png',
                      width: 510.0, height: 110.0),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
