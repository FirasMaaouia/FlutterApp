import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/Home/HomeScreen/popularListView.dart';
import 'package:esprit/Home/MyClippers/clipPath.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:esprit/SizeConfig.dart';
import 'package:esprit/Home/HomeScreen/categoryView.dart';
import 'package:esprit/Home/HomeScreen/constant.dart';
import 'package:esprit/static.dart';
import 'package:esprit/Home/HomeScreen/loading.dart';
import 'package:esprit/Home/HomeScreen/loadingtwo.dart';

class HomeUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            SizeConfig1().init(constraints, orientation);
            return Scaffold(
              backgroundColor: AppThemeColors.bgColor,
              body: HomeScreen(),
            );
          },
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            expandedHeight: 35 * SizeConfig1.heightMultiplier,
            flexibleSpace:
                FlexibleSpaceBar(background: getFlexibleSpaceAppBar())),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 3.45 * SizeConfig1.heightMultiplier,
                    ),
                    getCategoryList(),
                    SizedBox(
                      height: 4.45 * SizeConfig1.heightMultiplier,
                    ),
                    Container(
                      width: double.infinity,
                      color: AppThemeColors.bgColor,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 18,
                          top: 10,
                          bottom: 2.06 * SizeConfig1.heightMultiplier,
                        ),
                        child: Row(children: [
                          Text("Popular Courses",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: "muli",
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  fontSize: 2.8 * SizeConfig1.textMultiplier,
                                  color: AppThemeColors.pureBlack)),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoadingOne()));
                            },
                            child: new Text("View All",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: "muli",
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontSize: 2.2 * SizeConfig1.textMultiplier,
                                    color: AppThemeColors.darkBlue)),
                          ),
                        ]),
                      ),
                    ),
                    PopularListView(),
                  ],
                )),
          ]),
        )
      ],
    );
  }

  Widget getFlexibleSpaceAppBar() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: MyClippers(),
                child: Container(
                  height: 35 * SizeConfig1.heightMultiplier,
                  width: MediaQuery.of(context).size.width,
                  color: AppThemeColors.darkBlue,
                ),
              ),
              Positioned(
                bottom: 40,
                right: 0,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 12 * SizeConfig1.imageSizeMultiplier,
                      width: 12 * SizeConfig1.imageSizeMultiplier,
                      child: Image.asset("assets/images/nature.png"),
                    ),
                  ],
                ),
              ),
              getAppBar(),
            ],
          ),
        ],
      ),
    );
  }

  Widget getCategoryList() {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: 18, top: MediaQuery.of(context).viewPadding.top),
              child: Row(children: []),
            ),
            Row(children: [
              Text("  Popular Categories",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: "muli",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 2.8 * SizeConfig1.textMultiplier,
                      color: AppThemeColors.pureBlack)),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InfoScreen()));
                },
                child: new Text("View All",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: "muli",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 2.2 * SizeConfig1.textMultiplier,
                        color: AppThemeColors.darkBlue)),
              ),
            ]),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  PopularCard(
                    image: "assets/images/marketing.png",
                    title: "Marketing",
                    isActive: true,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  PopularCard(
                    image: "assets/images/coding.png",
                    title: "Coding",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  PopularCard(
                    image: "assets/images/app.png",
                    title: "UI/UX Design",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  PopularCard(
                    image: "assets/images/languages.png",
                    title: "Languages",
                  ),
                  PopularCard(
                    image: "assets/images/security.png",
                    title: "Security",
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            SizedBox(height: 20),
          ]),
    );
  }

  Widget getSearchBar() {
    return Padding(
      padding: EdgeInsets.only(top: 3 * SizeConfig1.heightMultiplier, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 73 * SizeConfig1.widthMultiplier,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppThemeColors.nearlyWhite,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Container(
                          child: TextField(
                            onSubmitted: (value) {
                              print("hey");
                            },
                            cursorColor: AppThemeColors.darkBlue,
                            keyboardType: TextInputType.text,
                            // textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontFamily: 'muli',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppThemeColors.pureBlack),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                hintText: "Search Here",
                                hintStyle: TextStyle(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)))),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      child: Icon(
                        Icons.search,
                        color: AppThemeColors.darkGrey.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getAppBar() {
    return Padding(
        padding: EdgeInsets.only(
            top: 2 * SizeConfig1.heightMultiplier, left: 18, right: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hey, what would\nyou like to learn \ntoday ?\n',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: "muli",
                          fontSize: 2.8 * SizeConfig1.textMultiplier,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          color: AppThemeColors.nearlyWhite),
                    ),
                    Text(
                      'Start exploring!',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: "muli",
                          fontSize: 2.8 * SizeConfig1.textMultiplier,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          color: AppThemeColors.nearlyWhite),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: AppThemeColors.nearlyWhite.withOpacity(0.2),
                      shape: BoxShape.circle),
                  height: 12 * SizeConfig1.imageSizeMultiplier,
                  width: 12 * SizeConfig1.imageSizeMultiplier,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/people.png"),
                  ),
                ),
                Text(
                  "${Userutils.name}",
                  style: TextStyle(
                      fontFamily: "muli",
                      fontWeight: FontWeight.bold,
                      fontSize: 1.8 * SizeConfig1.heightMultiplier,
                      letterSpacing: 1.0,
                      color: AppThemeColors.nearlyWhite),
                )
              ],
            )
          ],
        ));
  }
}

enum CategoryType { ui, markeitng, security, coding }

class PopularCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  const PopularCard({
    Key key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: kActiveShadowColor,
                )
              : BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  color: kShadowColor,
                ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Material(
              child: InkWell(
            onTap: () {
              ChosenCateg.chosen = title;
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Loading()));
            },
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(image, height: 90),
              ),
            ),
          )),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
