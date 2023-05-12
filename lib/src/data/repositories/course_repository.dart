import 'dart:convert';

import 'package:esprit/src/data/models/custom_error.dart';
import 'package:esprit/src/utils/custom_http_client.dart';
import 'package:esprit/src/utils/my_urls.dart';
import 'package:esprit/static.dart';

class CourseRepository {
  CustomHttpClient http = CustomHttpClient();
  String title = CourseUtils.title;
  String description = CourseUtils.description;
  String usermail = Userutils.email;

  String category = CourseUtils.category;
  String available = CourseUtils.available;
  String bprice = CourseUtils.bprice;
  String bdesc = CourseUtils.bdesc;
  String bhours = CourseUtils.bhours;
  String sprice = CourseUtils.sprice;
  String sdesc = CourseUtils.sdesc;
  String shours = CourseUtils.shours;
  String pprice = CourseUtils.pprice;
  String pdesc = CourseUtils.pdesc;
  String phours = CourseUtils.phours;
  String rating = "0.0";
  String imagepath = Userutils.email + ".png";
  String name = Userutils.name;
  Future<dynamic> addCourse(
      String title,
      String description,
      String usermail,
      String category,
      String available,
      String bprice,
      String bdesc,
      String bhours,
      String sprice,
      String sdesc,
      String shours,
      String pprice,
      String pdesc,
      String phours,
      String rating,
      String imagepath,
      String name) async {
    try {
      var body = jsonEncode({
        'title': title,
        'description': description,
        'usermail': usermail,
        'category': category,
        'available': available,
        'bprice': bprice,
        'bdesc': bdesc,
        'bhours': bhours,
        'sprice': sprice,
        'sdesc': sdesc,
        'shours': shours,
        'pprice': pprice,
        'pdesc': pdesc,
        'phours': phours,
        'rating': rating,
        'imagepath': imagepath,
        'name': name
      });
      var response = await http.post(
        '${MyUrls.serverUrl}/addCourse',
        body: body,
      );
      final dynamic courseResponse = jsonDecode(response.body);

      if (courseResponse['success'] == false) {
        return CustomError.fromJson(courseResponse);
      }
    } catch (err) {
      return CustomError(
        error: true,
        errorMessage: "There's an error, try again!",
      );
    }
  }

  Future<dynamic> editCourse(
    String title,
    String title1,
    String description,
    String category,
    String available,
    String bprice,
    String bdesc,
    String bhours,
    String sprice,
    String sdesc,
    String shours,
    String pprice,
    String pdesc,
    String phours,
  ) async {
    try {
      var body = jsonEncode({
        'title': title,
        'title1': title1,
        'description': description,
        'usermail': usermail,
        'category': category,
        'available': available,
        'bprice': bprice,
        'bdesc': bdesc,
        'bhours': bhours,
        'sprice': sprice,
        'sdesc': sdesc,
        'shours': shours,
        'pprice': pprice,
        'pdesc': pdesc,
        'phours': phours,
      });
      var response = await http.post(
        '${MyUrls.serverUrl}/updateCourse',
        body: body,
      );
      final dynamic courseResponse = jsonDecode(response.body);

      if (courseResponse['success'] == false) {
        return CustomError.fromJson(courseResponse);
      }
    } catch (err) {
      return CustomError(
        error: true,
        errorMessage: "There's an error, try again!",
      );
    }
  }
}
