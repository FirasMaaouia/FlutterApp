import 'package:animations/animations.dart';
import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/Home/Model/allListUI.dart';
import 'package:esprit/allCourseInfo.dart';
import 'package:flutter/material.dart';
import 'package:esprit/screens/courses/courseService.dart';
import 'package:esprit/screens/courses/coursesModel.dart';

// ignore: must_be_immutable
class CategCourses extends StatefulWidget {
  @override
  _CategCoursesState createState() => _CategCoursesState();
}

class _CategCoursesState extends State<CategCourses> {
  List<CourseList> _courses;
  int length;

  @override
  void initState() {
    Services.getCategCourses().then((courses) {
      setState(() {
        _courses = courses;
        length = _courses.length;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_courses.length == 0) {
      return Center(
        child: Text('No courses found!'),
      );
    } else {
      return Container(
        child: Expanded(
          child: GridView(
            padding: const EdgeInsets.only(top: 0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            children: List<Widget>.generate(length, (int index) {
              CourseList course = _courses[index];
              String title = course.title;
              String category = course.category;
              String name = course.fullname;
              String usermail = course.usermail;
              String description = course.description;
              String date = course.date;
              String available = course.available;
              String bprice = course.basicprice;
              String bdesc = course.basicdescription;
              String bhours = course.basichours;
              String sprice = course.standardprice;
              String sdesc = course.standarddesc;
              String shours = course.standardhours;
              String pprice = course.premiumprice;
              String pdesc = course.premiumdesc;
              String phours = course.premiumhours;
              double rating = course.ratingAvg;
              String imagePath = course.imagepath;
              return Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: OpenContainer(
                  openColor: AppThemeColors.darkBlue.withOpacity(0.15),
                  closedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  transitionType: ContainerTransitionType.fade,
                  transitionDuration: Duration(milliseconds: 800),
                  closedColor: AppThemeColors.bgColor,
                  closedElevation: 0.0,
                  openElevation: 0.0,
                  openBuilder: (context, _) {
                    return AllCourseInfo(
                        title: title,
                        category: category,
                        rating: rating,
                        imagePath: imagePath,
                        name: name,
                        usermail: usermail,
                        description: description,
                        date: date,
                        available: available,
                        bprice: bprice,
                        bdesc: bdesc,
                        bhours: bhours,
                        sprice: sprice,
                        sdesc: sdesc,
                        shours: shours,
                        pprice: pprice,
                        pdesc: pdesc,
                        phours: phours);
                  },
                  closedBuilder: (context, callBack) {
                    return AllCoursesUI(
                      courses: _courses[index],
                      onTab: callBack,
                    );
                  },
                ),
              );
            }),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 32.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 0.7,
            ),
          ),
        ),
      );
    }
  }
}
