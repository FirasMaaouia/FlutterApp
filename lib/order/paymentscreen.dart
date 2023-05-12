import 'dart:async';
import 'package:esprit/Home/HomeScreen/home.dart';
import 'package:esprit/screens/courses/laststep.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:esprit/src/utils/my_urls.dart';
import 'package:esprit/static.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

// ignore: must_be_immutable
class Paymee extends StatefulWidget {
  @override
  _PaymeeState createState() => _PaymeeState();
}

class _PaymeeState extends State<Paymee> {
  Timer timer;
  Completer<WebViewController> _c = Completer<WebViewController>();
  @override
  void initState() {
    CourseOrder.payment = "false";

    timer =
        Timer.periodic(Duration(seconds: 3), (Timer t) => getPaymentStatus());

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  final globalScaff = GlobalKey<ScaffoldState>();

  Future<void> getPaymentStatus() async {
    String check;

    var uri = Uri.parse(
        "https://sandbox.paymee.tn/api/v1/payments/${CourseOrder.token}/check");

    var request = new http.MultipartRequest("GET", uri);
    request.headers["Authorization"] =
        "Token ccc3751ae3ae852090a13b51e7b45f3bdbfcfe24";
    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value.toString());
      check = value.substring(70, value.toString().indexOf(',"token":'));
      CourseOrder.payment = check.substring(0, check.toString().indexOf(','));
      print(Math.newbalance);
      if (CourseOrder.payment == "true") {
        sendmail();
        createOrder();
        updateUserBalance();
        ToastUtils.showCustomToast(context, "Payment successfully completed");
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  static Future<void> updateUserBalance() async {
    var url = Uri.parse("${MyUrls.serverUrl}/updateBalance");

    Map data = {'email': CourseOrder.coursemail, 'balance': Math.newbalance};
    var body = json.encode(data);

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    String jsonsDataString = response.body.toString();
    // toString of Response's body is assigned to jsonDataString
    data = jsonDecode(jsonsDataString);
    if (response.statusCode == 200) {
      print('updated');
    }
  }

  sendmail() async {
    String username = 'learnlymobileapp@gmail.com';
    String password = 'Skotinka';

    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Learnly Mobile App')
      ..recipients.add(Userutils.email)
      ..subject = 'Order Successfully Compeleted #${CourseOrder.token}.'
      ..html =
          "<h1>Thank you for placing order using Learnly Mobile app!</h1>\n<h2><p>Order Summary:</p></h2>\n<p>Course Title: ${CourseOrder.title}</p>\n<p>Course Author: ${CourseOrder.author}</p>\n<p>Teacher Email: ${CourseOrder.coursemail}</p>\n<p>Total Price: ${CourseOrder.finalprice} TND</p>\n<p>Start Date: ${CourseOrder.startdate}</p>\n<p>Start Time: ${CourseOrder.starttime}</p>\n<p>Package: ${CourseOrder.chosenpackage}</p>\n<p>Status: Awaiting Teacher Confirmation</p>";
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    final message1 = Message()
      ..from = Address(username, 'Learnly Mobile App')
      ..recipients.add(CourseOrder.coursemail)
      ..subject = 'Order Successfully Compeleted #${CourseOrder.token}.'
      ..html =
          "<h1>${CourseOrder.usermail} Has just bought your course!</h1>\n<h2><p>Order Summary:</p></h2>\n<p>Course Title: ${CourseOrder.title}</p>\n<p>Course Author: ${CourseOrder.author}</p>\n<p>Teacher Email: ${CourseOrder.coursemail}</p>\n<p>Total Price: ${CourseOrder.finalprice} TND</p>\n<p>Start Date: ${CourseOrder.startdate}</p>\n<p>Start Time: ${CourseOrder.starttime}</p>\n<p>Package: ${CourseOrder.chosenpackage}</p>\n<p><h2>Your next step is to schedule a meet from Learnly and start teaching!</h2></p>";
    // Sending multiple messages with the same connection
    //
    // Create a smtp client that will persist the connection
    var connection = PersistentConnection(smtpServer);
    await connection.send(message1);
    await connection.close();
  }

  Future<http.Response> createOrder() async {
    var url = '${MyUrls.serverUrl}/createOrder';

    Map data = {
      'sendermail': Userutils.email,
      'sendername': Userutils.name,
      'senderusername': Userutils.username,
      'senderpackage': CourseOrder.chosenpackage,
      'courseemail': CourseOrder.usermail,
      'coursetitle': CourseOrder.title,
      'startdate': CourseOrder.startdate,
      'starttime': CourseOrder.starttime,
      'orderstatus': 'Completed',
      'teacherstatus': 'Awaiting teacher confirmation',
      'token': CourseOrder.token,
      'totalprice': CourseOrder.finalprice
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalScaff,
      appBar: AppBar(
        title: Text("Paymee.tn Gateway"),
      ),
      body: WebView(
        initialUrl: "https://sandbox.paymee.tn/gateway/${CourseOrder.token}",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _c.complete(webViewController);
        },
      ),
    );
  }
}
