import 'package:flutter/material.dart';

import 'package:esprit/screens/courses/addnewcoursetwo.dart';

class CreateNewCourseScreenTwo extends StatelessWidget {
  static String routeName = "/addnewcoursetwo";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Step two"),
      ),
      body: StepTwoForm(),
    );
  }
}
