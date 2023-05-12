import 'package:animations/animations.dart';
import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/Home/Model/popularList.dart';
import 'package:esprit/Home/Model/popularListUi.dart';
import 'package:esprit/courseInfo.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PopularListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: GridView(
          padding: const EdgeInsets.only(top: 0),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: List<Widget>.generate(popularCourse.length, (int index) {
            String title = popularCourse[index].title;
            String author = popularCourse[index].author;
            int money = popularCourse[index].money;
            double rating = popularCourse[index].rating;
            String imagePath = popularCourse[index].imagePath;
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
                  return CourseInfo(
                    title: title,
                    author: author,
                    money: money,
                    rating: rating,
                    imagePath: imagePath,
                  );
                },
                closedBuilder: (context, callBack) {
                  return PopularList(
                    popularCourse: popularCourse[index],
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
