import 'package:flutter/material.dart';
import 'package:esprit/components/coustom_bottom_nav_bar.dart';
import 'package:esprit/enums.dart';
import 'package:esprit/order/userorderpage.dart';

class OrdersScreen extends StatelessWidget {
  static String routeName = "/Orders";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrderPage(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.courses),
    );
  }
}
