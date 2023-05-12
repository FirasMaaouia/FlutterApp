import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/screens/profile/helpcenter.dart';
import 'package:esprit/static.dart';
import 'package:flutter/material.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:esprit/src/screens/settings/settings_controller.dart';
import 'package:esprit/screens/settings/settingspage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:esprit/src/utils/my_urls.dart';
import 'updatePass.dart';
import 'cashout.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  SettingsController _settingsController;

  static Future<void> getUserBalance() async {
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
    Userutils.balance = datax['balance'];
  }

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
    savemyUser();
    getUserType();
    getUserBalance();
    super.initState();
  }

  savemyUser() {
    if (_settingsController.myUser != null) {
      Userutils.email = "${_settingsController.myUser.email}";
      Userutils.username = "${_settingsController.myUser.username}";
      Userutils.name = "${_settingsController.myUser.name}";
      Userutils.profilepic = "${_settingsController.myUser.profilepic}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _settingsController.streamController.stream,
        builder: (context, snapshot) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                ProfilePic(),
                SizedBox(height: 20),
                Text("Welcome, ${Userutils.name}",
                    style: TextStyle(
                        fontFamily: "muli",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                        fontSize: 17,
                        color: AppThemeColors.darkBlue)),
                ProfileMenu(
                  text: "My Account",
                  icon: "assets/icons/User Icon.svg",
                  press: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PassScreen())),
                  },
                ),
                ProfileMenu(
                  text: "Cashout",
                  icon: "assets/icons/money.svg",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CashoutScreen()));
                  },
                ),
                ProfileMenu(
                  text: "Settings",
                  icon: "assets/icons/Settings.svg",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                  },
                ),
                ProfileMenu(
                    text: "Help Center",
                    icon: "assets/icons/Question mark.svg",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HelpCenter()));
                    }),
                ProfileMenu(
                  text: "Log Out",
                  icon: "assets/icons/Log out.svg",
                  press: () {
                    _settingsController.openModalExitApp();
                  },
                ),
              ],
            ),
          );
        });
  }
}
