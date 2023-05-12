import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/Home/MyClippers/clipPath.dart';
import 'package:flutter/material.dart';
import 'package:esprit/Home/Animations/delayedAnimation.dart';
import 'package:esprit/Home/Animations/scaleAnimation.dart';
import 'SizeConfig.dart';

class CourseInfo extends StatefulWidget {
  final String title;
  final String author;
  final int money;
  final double rating;
  final String imagePath;
  const CourseInfo(
      {Key key,
      this.title,
      this.author,
      this.money,
      this.rating,
      this.imagePath})
      : super(key: key);
  @override
  _CourseInfoState createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo> {
  String bdesc =
      "I will teach you how you can create a simple UI for your mobile application with Flutter!, If you are new and you want to learn Flutter UI Design, you came to the right place! I am a professional teacher.";
  int hours = 2;

  void changeBasicData() {
    setState(() {
      bdesc =
          "I will teach you how you can create a simple UI for your mobile application with Flutter!";
      hours = 2;
    });
  }

  void changeStandardData() {
    setState(() {
      bdesc =
          "I will show you more advanced techniques on how you can create a perfect design for you app!";
      hours = 5;
    });
  }

  void changePremiumData() {
    setState(() {
      bdesc =
          "I will provide you with many cool designs and templates and show how you can integrate them in your app, with 5 years of experience in mobile design I can show you create anything you want me to do!";
      hours = 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          SizeConfig1().init(constraints, orientation);
          return Scaffold(
              backgroundColor: AppThemeColors.bgColor,
              body: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SafeArea(
                      child: Stack(
                        children: <Widget>[
                          ClipPath(clipper: MyClippers(), child: imageCentre()),
                          Positioned(
                            left: 20,
                            bottom: 5,
                            child: exitBtn(),
                          ),
                          Positioned(
                              right: 20, bottom: 5, child: starDecoration())
                        ],
                      ),
                    ),
                    title(),
                    SizedBox(height: 1.2 * SizeConfig1.heightMultiplier),
                    moneyAndStar(),
                    SizedBox(height: 1.2 * SizeConfig1.heightMultiplier),
                    author(),
                    SizedBox(height: 3 * SizeConfig1.heightMultiplier),
                    boxUi(),
                    discriptionText(),
                    belowButton()
                  ],
                ),
              ));
        },
      );
    });
  }

  Widget author() {
    return Container(
      width: 100.5 * SizeConfig1.widthMultiplier,
      child: Padding(
        padding: const EdgeInsets.only(left: 18, top: 10, right: 18),
        child: Text(
          "Author: ${widget.author}",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontFamily: "muli",
              fontWeight: FontWeight.bold,
              fontSize: 2 * SizeConfig1.textMultiplier,
              color: AppThemeColors.pureBlack),
        ),
      ),
    );
  }

  Widget belowButton() {
    return Container(
      // color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Row(
          children: <Widget>[
            Text("Hours: $hours",
                style: TextStyle(
                    fontFamily: "muli",
                    fontWeight: FontWeight.bold,
                    fontSize: 2.5 * SizeConfig1.textMultiplier,
                    letterSpacing: 0.27,
                    color: AppThemeColors.pureBlack)),
            SizedBox(width: 4.7 * SizeConfig1.widthMultiplier),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 2 * SizeConfig1.heightMultiplier),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppThemeColors.darkBlue,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 15,
                            color: AppThemeColors.darkGrey.withOpacity(0.2),
                            offset: Offset(0, 15))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.6 * SizeConfig1.heightMultiplier),
                      child: Text("Buy Course",
                          style: TextStyle(
                              fontFamily: "muli",
                              fontWeight: FontWeight.bold,
                              fontSize: 2.5 * SizeConfig1.textMultiplier,
                              letterSpacing: 0.27,
                              color: AppThemeColors.nearlyWhite)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget discriptionText() {
    return Flexible(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Padding(
            padding: EdgeInsets.only(top: 1.6 * SizeConfig1.heightMultiplier),
            child: Container(
              child: Center(
                child: Text("$bdesc",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "muli",
                        fontSize: 2.1 * SizeConfig1.textMultiplier,
                        letterSpacing: 0.27,
                        color: AppThemeColors.pureBlack)),
              ),
            ),
          ),
        ));
  }

  Widget boxUi() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new GestureDetector(
              onTap: () {
                changeBasicData();
              },
              child: DelayedAnimation(
                  delayDuration: 100,
                  aniDuration: 700,
                  anioffsetX: -1.35,
                  anioffsetY: 0.0,
                  child: animatedBoxUi("Basic", "Plan")),
            ),
            new GestureDetector(
              onTap: () {
                changeStandardData();
              },
              child: DelayedAnimation(
                  delayDuration: 300,
                  aniDuration: 700,
                  anioffsetX: -1.35,
                  anioffsetY: 0.0,
                  child: animatedBoxUi("Standard", "Plan")),
            ),
            new GestureDetector(
              onTap: () {
                changePremiumData();
              },
              child: DelayedAnimation(
                  delayDuration: 500,
                  aniDuration: 700,
                  anioffsetX: -1.35,
                  anioffsetY: 0.0,
                  child: animatedBoxUi("Premium", "Plan")),
            ),
          ],
        ),
      ),
    );
  }

  Widget animatedBoxUi(String s1, String s2) {
    return Container(
      height: 18.5 * SizeConfig1.widthMultiplier,
      width: 11.23 * SizeConfig1.heightMultiplier,
      decoration: BoxDecoration(
        color: AppThemeColors.darkBlue,
        boxShadow: [
          BoxShadow(
              blurRadius: 15,
              color: AppThemeColors.darkGrey.withOpacity(0.2),
              offset: Offset(0, 15))
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(s1,
              style: TextStyle(
                  fontFamily: "muli",
                  fontWeight: FontWeight.bold,
                  fontSize: 2 * SizeConfig1.textMultiplier,
                  letterSpacing: 0.27,
                  color: AppThemeColors.nearlyWhite)),
          Text(s2,
              style: TextStyle(
                  fontFamily: "muli",
                  // fontWeight: FontWeight.bold,
                  fontSize: 1.8 * SizeConfig1.textMultiplier,
                  letterSpacing: 0.27,
                  color: AppThemeColors.nearlyWhite)),
        ],
      ),
    );
  }

  Widget moneyAndStar() {
    return Container(
        child: Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${widget.money} TND / Hour",
            style: TextStyle(
                fontFamily: "muli",
                fontWeight: FontWeight.bold,
                fontSize: 2.3 * SizeConfig1.textMultiplier,
                letterSpacing: 0.27,
                color: AppThemeColors.darkBlue),
          ),
          Row(
            children: <Widget>[
              DelayedAnimation(
                aniDuration: 700,
                anioffsetX: 0.0,
                anioffsetY: 1.35,
                delayDuration: 100,
                child: Text(
                  "${widget.rating}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: "muli",
                      fontWeight: FontWeight.bold,
                      fontSize: 2.3 * SizeConfig1.textMultiplier,
                      letterSpacing: 0.27,
                      color: Colors.black),
                ),
              ),
              ScaleAnimation(
                delayDuration: 100,
                aniDuration: 800,
                child: Icon(
                  Icons.star,
                  color: Colors.red[300],
                  size: 2.8 * SizeConfig1.heightMultiplier,
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }

  Widget title() {
    return Container(
      width: 102.5 * SizeConfig1.widthMultiplier,
      child: Padding(
        padding: const EdgeInsets.only(left: 18, top: 20, right: 18),
        child: Text(
          "${widget.title}",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontFamily: "muli",
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              fontSize: 2.8 * SizeConfig1.textMultiplier,
              color: AppThemeColors.pureBlack),
        ),
      ),
    );
  }

  Widget starDecoration() {
    return ScaleAnimation(
      delayDuration: 100,
      aniDuration: 800,
      child: Container(
        height: 6 * SizeConfig1.heightMultiplier,
        width: 11 * SizeConfig1.widthMultiplier,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 10,
              color: AppThemeColors.darkBlue.withOpacity(0.2),
              offset: Offset(0, 3))
        ], color: AppThemeColors.nearlyWhite, shape: BoxShape.circle),
        child: Icon(
          Icons.star,
          size: 4 * SizeConfig1.heightMultiplier,
          color: AppThemeColors.darkBlue,
        ),
      ),
    );
  }

  Widget imageCentre() {
    return Container(
      color: AppThemeColors.darkBlue,
      height: 35 * SizeConfig1.heightMultiplier,
      width: double.infinity,
      child: Container(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ScaleAnimation(
            delayDuration: 100,
            aniDuration: 500,
            child: Image.asset(widget.imagePath)),
      )),
    );
  }

  Widget exitBtn() {
    return ScaleAnimation(
      delayDuration: 100,
      aniDuration: 800,
      child: Container(
          height: 6 * SizeConfig1.heightMultiplier,
          width: 11 * SizeConfig1.widthMultiplier,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                blurRadius: 10,
                color: AppThemeColors.darkBlue.withOpacity(0.2),
                offset: Offset(0, 3))
          ], color: AppThemeColors.nearlyWhite, shape: BoxShape.circle),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            iconSize: 20,
            color: Colors.blueAccent,
            onPressed: () {
              Navigator.pop(context);
            },
          )),
    );
  }
}
