import 'package:esprit/static.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:esprit/src/utils/my_urls.dart';
import 'package:esprit/SizeConfig.dart';
import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/screens/profile/profile_screen.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool test;

  String type = "Teacher";
  @override
  void initState() {
    if (Userutils.current == "Teacher") {
      test = true;
    } else if (Userutils.current == "Learner") {
      test = false;
    }

    super.initState();
  }

  static Future<void> updateType() async {
    var url = Uri.parse("${MyUrls.serverUrl}/updateType");
    Map data = {'email': Userutils.email, 'type': Userutils.type};
    var body = json.encode(data);
    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      if (200 == response.statusCode) {
        return "success";
      } else {
        // ignore: deprecated_member_use
        return "no success";
      }
    } catch (e) {
      // ignore: deprecated_member_use
      return "error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Settings Page"),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () =>
              Navigator.pushNamed(context, ProfileScreen.routeName),
        ),
      ),
      // body is the majority of the screen.
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                SizedBox(height: 150),
                Text(" Teacher Mode",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: "muli",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        fontSize: 2.8 * SizeConfig1.textMultiplier,
                        color: AppThemeColors.darkBlue)),
                Spacer(),
                LiteRollingSwitch(
                  //initial value
                  value: test,
                  textOn: 'Enabled',
                  textOff: 'Disabled',
                  colorOn: Colors.greenAccent[700],
                  colorOff: Colors.redAccent[700],
                  iconOn: Icons.done,
                  iconOff: Icons.remove_circle_outline,
                  textSize: 16.0,
                  onChanged: (bool state) {
                    if (state == true) {
                      Userutils.type = "Teacher";
                      updateType();
                    } else {
                      Userutils.type = "Learner";
                      updateType();
                    }
                  },
                ),
              ],
            ),
            Container(
              width: 400,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blue,
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/newsletterdisabled.png',
                      width: 100,
                      height: 100,
                    ),
                    Text("Get the most out of Learnly!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "muli",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontSize: 2.8 * SizeConfig1.textMultiplier,
                            color: AppThemeColors.nearlyWhite)),
                    SizedBox(height: 10),
                    Text(
                        "Keep yourself updated by subscribing to our newsletter!\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "muli",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontSize: 2.2 * SizeConfig1.textMultiplier,
                            color: AppThemeColors.nearlyWhite)),
                    LiteRollingSwitch(
                      //initial value
                      textOn: 'Subscribed',
                      textOff: 'Disabled',
                      colorOn: Colors.greenAccent[700],
                      colorOff: Colors.redAccent[700],
                      iconOn: Icons.done,
                      iconOff: Icons.remove_circle_outline,
                      textSize: 16.0,
                      onChanged: (bool state) {},
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
