import 'package:flutter/material.dart';
import 'package:esprit/components/coustom_bottom_nav_bar.dart';
import 'package:esprit/enums.dart';

import 'package:esprit/Home/HomeScreen/homeUi.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeUi(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
