import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/Home/MyClippers/clipPath.dart';
import 'package:flutter/material.dart';
import 'package:esprit/Home/Animations/delayedAnimation.dart';
import 'package:esprit/Home/Animations/scaleAnimation.dart';
import 'SizeConfig.dart';
import 'package:esprit/static.dart';
import 'package:esprit/src/utils/my_urls.dart';
import 'package:esprit/order/buycoursescreen.dart';
import 'package:esprit/screens/courses/laststep.dart';
import 'package:esprit/screens/rating/rating.dart';

class AllCourseInfo extends StatefulWidget {
  final String id;
  final String title;
  final String category;
  final double rating;
  final String imagePath;
  final String available;
  final String name;
  final String date;
  final String description;
  final String usermail;
  final String bprice;
  final String bdesc;
  final String bhours;
  final String sprice;
  final String sdesc;
  final String shours;
  final String pprice;
  final String pdesc;
  final String phours;

  const AllCourseInfo({
    Key key,
    this.id,
    this.title,
    this.category,
    this.rating,
    this.imagePath,
    this.available,
    this.name,
    this.date,
    this.description,
    this.usermail,
    this.bprice,
    this.bdesc,
    this.bhours,
    this.sprice,
    this.sdesc,
    this.shours,
    this.pprice,
    this.pdesc,
    this.phours,
  }) : super(key: key);
  @override
  _AllCourseInfoState createState() => _AllCourseInfoState();
}

class _AllCourseInfoState extends State<AllCourseInfo> {
  AllCourseInfo cousre;
  String bdesc;
  String hours;
  String pprice;

  @override
  void initState() {
    super.initState();
    bdesc = widget.description;
    hours = widget.bhours;
    pprice = "Starting from: " + widget.bprice;
    CourseOrder.title = widget.title;
    CourseOrder.author = widget.name;
    CourseOrder.coursemail = widget.usermail;
    CourseOrder.usermail = Userutils.email;
    CourseOrder.category = widget.category;
    CourseOrder.available = widget.available;
    CourseOrder.description = widget.description;
    CourseOrder.bprice = widget.bprice;
    CourseOrder.sprice = widget.sprice;
    CourseOrder.pprice = widget.pprice;
    RatingT.title = widget.title;
    RatingT.id = widget.id;
  }

  void changeBasicData() {
    setState(() {
      bdesc = "${widget.bdesc}";
      hours = "${widget.bhours}";
      pprice = "${widget.bprice}";
    });
  }

  void changeStandardData() {
    setState(() {
      bdesc = "${widget.sdesc}";
      hours = "${widget.shours}";
      pprice = "${widget.sprice}";
    });
  }

  void changePremiumData() {
    setState(() {
      bdesc = "${widget.pdesc}";
      hours = "${widget.phours}";
      pprice = "${widget.pprice}";
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
                    SizedBox(height: 0.5 * SizeConfig1.heightMultiplier),
                    author(),
                    SizedBox(height: 0.5 * SizeConfig1.heightMultiplier),
                    Text(
                      "    Available from:  ${widget.available}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: "muli",
                          fontWeight: FontWeight.bold,
                          fontSize: 2 * SizeConfig1.textMultiplier,
                          color: AppThemeColors.pureBlack),
                    ),
                    SizedBox(height: 3 * SizeConfig1.heightMultiplier),
                    boxUi(),
                    descriptionText(),
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
        child: Row(children: [
          Text(
            "Author: ${widget.name}",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "muli",
                fontWeight: FontWeight.bold,
                fontSize: 2 * SizeConfig1.textMultiplier,
                color: AppThemeColors.pureBlack),
          ),
          Spacer(),
          Text("Posted: ${widget.date}",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: "muli",
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                  fontSize: 1.5 * SizeConfig1.textMultiplier,
                  color: AppThemeColors.pureBlack)),
        ]),
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
            Text("$hours",
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
                        child: InkWell(
                          child: Text("Buy Course",
                              style: TextStyle(
                                  fontFamily: "muli",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 2.5 * SizeConfig1.textMultiplier,
                                  letterSpacing: 0.27,
                                  color: AppThemeColors.nearlyWhite)),
                          onTap: () {
                            if (Userutils.email == CourseOrder.coursemail) {
                              ToastUtils.showCustomToast(
                                  context, "You can't buy your own course!");
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BuyScreen()));
                            }
                          },
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget descriptionText() {
    return Flexible(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
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
                  child: animatedBoxUi("Basic", "Package")),
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
                  child: animatedBoxUi("Standard", "Package")),
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
                  child: animatedBoxUi("Premium", "Package")),
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
            "$pprice TND",
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
        child: IconButton(
          icon: Icon(Icons.star),
          iconSize: 30,
          color: AppThemeColors.darkBlue,
          onPressed: () {
            Navigator.pop(context);

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Ratings()));
          },
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
            child: Image.network(
                "${MyUrls.serverUrl}/uploads/${widget.imagePath}")),
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
