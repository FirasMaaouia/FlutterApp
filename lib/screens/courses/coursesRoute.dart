import 'package:flutter/material.dart';
import 'package:esprit/components/coustom_bottom_nav_bar.dart';
import 'package:esprit/enums.dart';
import 'package:esprit/screens/courses/courses.dart';

class CoursesScreen extends StatelessWidget {
  static String routeName = "/Course";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Coursespage(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.courses),
    );
  }
}
