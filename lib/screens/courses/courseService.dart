import 'package:esprit/src/utils/my_urls.dart';
import 'package:http/http.dart' as http;
import 'coursesModel.dart';
import 'package:esprit/static.dart';
import 'dart:convert';

class Services {
  static String url = '${MyUrls.serverUrl}/getCourse';
  static String userurl = '${MyUrls.serverUrl}/getuserCourse';
  static String categurl = '${MyUrls.serverUrl}/getcategCourse';

  static Future<List<CourseList>> getCourses() async {
    try {
      final response = await http.get(
        url,
      );
      if (200 == response.statusCode) {
        final List<CourseList> courses = courseListFromJson(response.body);
        return courses;
      } else {
        // ignore: deprecated_member_use
        return List<CourseList>();
      }
    } catch (e) {
      // ignore: deprecated_member_use
      return List<CourseList>();
    }
  }

  static Future<List<CourseList>> getuserCourses() async {
    Map data = {
      'usermail': Userutils.email,
    };
    var body = json.encode(data);
    try {
      final response = await http.post(userurl,
          headers: {"Content-Type": "application/json"}, body: body);
      if (200 == response.statusCode) {
        final List<CourseList> courses = courseListFromJson(response.body);
        return courses;
      } else {
        // ignore: deprecated_member_use
        return List<CourseList>();
      }
    } catch (e) {
      // ignore: deprecated_member_use
      return List<CourseList>();
    }
  }

  static Future<List<CourseList>> getCategCourses() async {
    Map data = {
      'category': ChosenCateg.chosen,
    };
    var body = json.encode(data);
    try {
      final response = await http.post(categurl,
          headers: {"Content-Type": "application/json"}, body: body);
      if (200 == response.statusCode) {
        final List<CourseList> courses = courseListFromJson(response.body);
        return courses;
      } else {
        // ignore: deprecated_member_use
        return List<CourseList>();
      }
    } catch (e) {
      // ignore: deprecated_member_use
      return List<CourseList>();
    }
  }
}
