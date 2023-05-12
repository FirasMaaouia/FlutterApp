import 'package:esprit/screens/chat/chat_screen.dart';
import 'package:esprit/src/screens/settings/settings_controller.dart';
import 'package:esprit/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:esprit/Home/HomeScreen/home.dart';
import 'package:esprit/screens/profile/profile_screen.dart';
import 'package:esprit/screens/courses/coursesRoute.dart';
import 'package:esprit/order/userOrderScreen.dart';
import '../constants.dart';
import '../enums.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:esprit/src/utils/my_urls.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  SettingsController _settingsController;

  static Future<void> getUserType() async {
    var url = Uri.parse("${MyUrls.serverUrl}/getuserType");
    String one;
    String two;

    Map data = {'email': Userutils.email};
    var body = json.encode(data);

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    String jsonsDataString = response.body.toString();
    // toString of Response's body is assigned to jsonDataString
    data = jsonDecode(jsonsDataString);
    one =
        jsonsDataString.substring(0, jsonsDataString.toString().indexOf(']}'));
    two = one.substring(9);
    Map<String, dynamic> datax = jsonDecode(two);
    Userutils.current = "${datax['type']}";
  }

  @override
  void initState() {
    _settingsController = SettingsController(context: context);
    super.initState();
  }

  savemyUser() {
    if (_settingsController.myUser != null) {
      Userutils.email = "${_settingsController.myUser.email}";
      Userutils.username = "${_settingsController.myUser.username}";
      Userutils.name = "${_settingsController.myUser.name}";
      Userutils.profilepic = "${_settingsController.myUser.profilepic}";
      Userutils.type = "${_settingsController.myUser.type}";
    }
  }

  static Future<void> getUserPic() async {
    var url = Uri.parse("${MyUrls.serverUrl}/getuserType");
    String one;
    String two;

    Map data = {'email': Userutils.email};
    var body = json.encode(data);

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    String jsonsDataString = response.body.toString();
    // toString of Response's body is assigned to jsonDataString
    data = jsonDecode(jsonsDataString);

    one =
        jsonsDataString.substring(0, jsonsDataString.toString().indexOf(']}'));

    two = one.substring(9);

    Map<String, dynamic> datax = jsonDecode(two);
    Userutils.profilepic = datax['profilepic'];
    Userutils.name = datax['name'];
  }

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return StreamBuilder<Object>(
        stream: _settingsController.streamController.stream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -15),
                  blurRadius: 10,
                  color: Color(0xFFDADADA).withOpacity(0.6),
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        icon: SvgPicture.asset(
                          "assets/icons/HomeIcon.svg",
                          color: MenuState.home == widget.selectedMenu
                              ? kPrimaryColor
                              : inActiveIconColor,
                        ),
                        onPressed: () {
                          savemyUser();
                          getUserType();
                          Navigator.pushNamed(context, HomeScreen.routeName);
                        }),
                    IconButton(
                        icon: SvgPicture.asset("assets/icons/Bell.svg"),
                        color: MenuState.notifications == widget.selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                        onPressed: () async {
                          Navigator.pushNamed(context, ProfileScreen.routeName);
                        }),
                    IconButton(
                        icon: SvgPicture.asset(
                          "assets/icons/mortarboard.svg",
                          color: MenuState.courses == widget.selectedMenu
                              ? kPrimaryColor
                              : inActiveIconColor,
                        ),
                        onPressed: () async {
                          savemyUser();
                          getUserType();
                          if (Userutils.current == "Learner") {
                            Navigator.pushNamed(
                                context, OrdersScreen.routeName);
                          } else {
                            Navigator.pushNamed(
                                context, CoursesScreen.routeName);
                          }
                        }),
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/Chat bubble Icon.svg",
                        color: MenuState.chatroom == widget.selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, ChatNav.routeName),
                    ),
                    IconButton(
                        icon: SvgPicture.asset(
                          "assets/icons/User Icon.svg",
                          color: MenuState.profile == widget.selectedMenu
                              ? kPrimaryColor
                              : inActiveIconColor,
                        ),
                        onPressed: () async {
                          getUserPic();
                          Navigator.pushNamed(context, ProfileScreen.routeName);
                        }),
                  ],
                )),
          );
        });
  }
}
