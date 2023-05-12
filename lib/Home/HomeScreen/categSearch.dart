import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/Home/HomeScreen/CatCourses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:esprit/SizeConfig.dart';
import 'package:esprit/static.dart';

class CategSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            SizeConfig1().init(constraints, orientation);

            return Scaffold(
              backgroundColor: AppThemeColors.nearlyWhite,
              body: AllCoursesScreen(),
            );
          },
        );
      },
    );
  }
}

class AllCoursesScreen extends StatefulWidget {
  @override
  _AllCoursesScreenState createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<AllCoursesScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            flexibleSpace:
                FlexibleSpaceBar(background: getFlexibleSpaceAppBar())),
        SliverList(
          delegate: SliverChildListDelegate([
            Text(
              " \" ${ChosenCateg.chosen} \" Results:",
              style: TextStyle(
                  fontFamily: "muli",
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  fontSize: 2.8 * SizeConfig1.textMultiplier,
                  color: AppThemeColors.darkBlue),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    CategCourses(),
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
        ],
      ),
    );
  }
}
