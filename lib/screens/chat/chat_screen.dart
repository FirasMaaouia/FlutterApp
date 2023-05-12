import 'package:esprit/src/screens/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:esprit/components/coustom_bottom_nav_bar.dart';
import 'package:esprit/enums.dart';

class ChatNav extends StatelessWidget {
  static String routeName = "/chatroom";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatScreen(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.chatroom),
    );
  }
}
