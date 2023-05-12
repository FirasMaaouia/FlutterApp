import 'package:flutter/material.dart';

import 'cashoutscreen.dart';
import 'package:esprit/screens/profile/profile_screen.dart';
class CashoutScreen extends StatelessWidget {
  static String routeName = "/cashout";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      appBar: AppBar(
        title: new Text("Cashout"),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () =>
              Navigator.pushNamed(context, ProfileScreen.routeName),
        ),
      ),
    );
  }
}
