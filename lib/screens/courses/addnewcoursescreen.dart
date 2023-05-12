import 'package:flutter/material.dart';

import 'package:esprit/screens/courses/addnewcourse.dart';

class CreateNewCourseScreen extends StatelessWidget {
  static String routeName = "/addnewcourse";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Step"),
      ),
      body: AddnewForm(),
    );
  }
}
