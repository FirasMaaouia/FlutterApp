import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/SizeConfig.dart';
import 'package:esprit/chatbot/dialogflow.dart';
import 'package:esprit/static.dart';
import 'package:wiredash/wiredash.dart';

class HelpCenter extends StatefulWidget {
  @override
  _HelpCenterState createState() => new _HelpCenterState();
}

var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

class _HelpCenterState extends State<HelpCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Help Center",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                  fontSize: 2.5 * SizeConfig1.textMultiplier,
                  color: AppThemeColors.pureBlack)),
        ),
        body: new SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                  "Have any question in mind? ask our smart chatbot and get the answer you need!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "muli",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 2.8 * SizeConfig1.textMultiplier,
                      color: AppThemeColors.darkBlue)),
              SizedBox(height: 30),
              Center(
                child: NiceButton(
                  background: Colors.blue,
                  radius: 40,
                  padding: const EdgeInsets.all(15),
                  text: "Learnly Chatbot",
                  icon: Icons.chat_bubble_outline_sharp,
                  gradientColors: [secondColor, firstColor],
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatbotDialogflow()));
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                  "If you want to give a feedback / report a bug within our application, press the button below!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "muli",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 2.8 * SizeConfig1.textMultiplier,
                      color: AppThemeColors.darkBlue)),
              SizedBox(
                height: 30,
              ),
              Center(
                child: NiceButton(
                  background: Colors.blue,
                  radius: 30,
                  padding: const EdgeInsets.all(15),
                  text: "Problem / Feedback",
                  icon: Icons.send_to_mobile,
                  gradientColors: [secondColor, firstColor],
                  onPressed: () {
                    Wiredash.of(context).setUserProperties(
                      userEmail: Userutils.email,
                    );
                    Wiredash.of(context).show();
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
