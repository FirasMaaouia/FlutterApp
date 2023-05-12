import 'package:http/http.dart' as http;
import 'package:esprit/src/utils/my_urls.dart';
import 'dart:convert';
import 'package:esprit/static.dart';
import 'outputmodel.dart';

class Service {
  //
  static String url = '${MyUrls.serverUrl}/searchCourse';
  static Future<List<Myratings>> getRatings() async {
    Map data = {
      "title": RatingT.title,
    };
    var body = json.encode(data);
    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);

      if (200 == response.statusCode) {
        final List<Myratings> ratings = myratingsFromJson(response.body);
        return ratings;
      } else {
        // ignore: deprecated_member_use
        return List<Myratings>();
      }
    } catch (e) {
      // ignore: deprecated_member_use
      return List<Myratings>();
    }
  }
}
