import 'dart:math';
import 'package:esprit/src/utils/my_urls.dart';
import 'package:esprit/static.dart';
import 'package:flutter/material.dart';

class UserInfoItem extends StatelessWidget {
  final String name;
  final String subtitle;

  UserInfoItem({
    @required this.name,
    this.subtitle,
  });

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            width: 1,
            color: Color(0xFFDDDDDD),
          ),
          bottom: BorderSide(
            width: 1,
            color: Color(0xFFDDDDDD),
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: <Widget>[
          renderProfilePic(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderProfilePic() {
    String lol = generateRandomString(2);
    return CircleAvatar(
      backgroundImage: NetworkImage(
          "${MyUrls.serverUrl}/uploads/" + Userutils.profilepic + '#' + lol),
    );
  }
}
