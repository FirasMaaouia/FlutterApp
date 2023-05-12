import 'dart:math';

import 'package:esprit/screens/profile/updatepic.dart';
import 'package:esprit/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:esprit/src/screens/settings/settings_controller.dart';
import 'package:esprit/src/utils/my_urls.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  SettingsController _settingsController;

  @override
  void initState() {
    _settingsController = SettingsController(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _settingsController.streamController.stream,
        builder: (context, snapshot) {
          return SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                renderMyUserCard(),
                Positioned(
                  right: -16,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.white),
                      ),
                      color: Color(0xFFF5F6F9),
                      onPressed: () {
                        savemyUser();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageUpload()),
                        );
                      },
                      child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  savemyUser() {
    if (_settingsController.myUser != null) {
      Userutils.email = "${_settingsController.myUser.email}";
      Userutils.username = "${_settingsController.myUser.username}";
      Userutils.name = "${_settingsController.myUser.name}";
      Userutils.profilepic = "${_settingsController.myUser.profilepic}";
    }
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  Widget renderMyUserCard() {
    String lol = generateRandomString(2);

    if (_settingsController.myUser != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(
            "${MyUrls.serverUrl}/uploads/${Userutils.profilepic}" + '#' + lol),
      );
    }
    return Container();
  }
}
