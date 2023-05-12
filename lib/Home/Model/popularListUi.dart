import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/Home/Model/popularCourse.dart';
import 'package:flutter/material.dart';
import 'package:esprit/SizeConfig.dart';

class PopularList extends StatelessWidget {
  final PopularCourse popularCourse;
  final Function onTab;

  const PopularList({Key key, this.popularCourse, this.onTab})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66.1290322581 * SizeConfig1.heightMultiplier,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 0, left: 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: onTab,
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppThemeColors.darkBlue.withOpacity(0.15),
                          borderRadius: BorderRadius.all(Radius.circular(
                              3.87096774194 * SizeConfig1.heightMultiplier))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15,
                                top: 1.3 * SizeConfig1.heightMultiplier,
                                right: 15),
                            child: Text(
                              "${popularCourse.title}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "muli",
                                  fontSize: 2.06 * SizeConfig1.heightMultiplier,
                                  letterSpacing: 0.27,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15,
                                top: 2.58064516129 *
                                    SizeConfig1.heightMultiplier,
                                right: 15),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Author:\n${popularCourse.author}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: "muli",
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            1.40 * SizeConfig1.textMultiplier,
                                        letterSpacing: 0.17,
                                        color: Colors.black.withOpacity(0.7)),
                                  ),
                                  Container(
                                    child: Row(children: <Widget>[
                                      Text(
                                        "${popularCourse.rating}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: "muli",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 1.34 *
                                                SizeConfig1.textMultiplier,
                                            letterSpacing: 0.11,
                                            color: Colors.black),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.red[300],
                                        size:
                                            1.5 * SizeConfig1.heightMultiplier,
                                      ),
                                    ]),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Image.asset(popularCourse.imagePath,
                                  fit: BoxFit.contain),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
