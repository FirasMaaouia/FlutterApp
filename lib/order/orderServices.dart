import 'package:http/http.dart' as http;
import 'ordermodel.dart';
import 'package:esprit/src/utils/my_urls.dart';
import 'dart:convert';
import 'package:esprit/static.dart';

class Service {
  //
  static String url = '${MyUrls.serverUrl}/userorder';
  static Future<List<Order>> getOrders() async {
    Map data = {
      "sendermail": Userutils.email,
    };
    var body = json.encode(data);
    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);

      if (200 == response.statusCode) {
        final List<Order> orders = orderFromJson(response.body);
        return orders;
      } else {
        // ignore: deprecated_member_use
        return List<Order>();
      }
    } catch (e) {
      // ignore: deprecated_member_use
      return List<Order>();
    }
  }
}
