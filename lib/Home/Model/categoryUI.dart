import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/Home/Model/category.dart';
import 'package:flutter/material.dart';
import 'package:esprit/SizeConfig.dart';

class CategoryUi extends StatefulWidget {
  final Category category;

  const CategoryUi({Key key, this.category}) : super(key: key);
  @override
  _CategoryUiState createState() => _CategoryUiState();
}

class _CategoryUiState extends State<CategoryUi> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75 * SizeConfig1.widthMultiplier,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Container(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 4 * SizeConfig1.widthMultiplier,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppThemeColors.darkBlue.withOpacity(0.15),
                        borderRadius: BorderRadius.all(Radius.circular(
                            4.87096774194 * SizeConfig1.heightMultiplier)),
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 23 * SizeConfig1.widthMultiplier,
                          ),
                          Expanded(
                              child: Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 1.3 * SizeConfig1.heightMultiplier,
                                    right: 6 * SizeConfig1.widthMultiplier,
                                  ),
                                  child: Container(
                                    // alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${widget.category.name}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "muli",
                                          fontSize: 2.06 *
                                              SizeConfig1.heightMultiplier,
                                          letterSpacing: 0.27,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 2.46 * SizeConfig1.widthMultiplier,
                                      bottom:
                                          1.28 * SizeConfig1.heightMultiplier,
                                      top: 0.64 * SizeConfig1.heightMultiplier),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontFamily: "muli",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 1.54 *
                                                  SizeConfig1.textMultiplier,
                                              letterSpacing: 0.27,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                        Container(
                                          child: Row(children: <Widget>[
                                            Text(
                                              "${widget.category.rating}",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontFamily: "muli",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 1.54 *
                                                      SizeConfig1
                                                          .textMultiplier,
                                                  letterSpacing: 0.27,
                                                  color: Colors.black),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.red[300],
                                              size: 2.6 *
                                                  SizeConfig1.heightMultiplier,
                                            ),
                                          ]),
                                        )
                                      ]),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 0,
                                      right: 1 * SizeConfig1.widthMultiplier,
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "   ${widget.category.badge}",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontFamily: "italic",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 2 *
                                                    SizeConfig1.textMultiplier,
                                                letterSpacing: 0.27,
                                                color: AppThemeColors.darkBlue),
                                          ),
                                        ]))
                              ])))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 15,
            bottom: 15,
            left: 18,
            child: Container(
              height: 100,
              width: 100,
              // height: 10.3225806452 * SizeConfig1.heightMultiplier,
              // width: 19.4647201946 * SizeConfig1.widthMultiplier,
              decoration: BoxDecoration(
                  color: AppThemeColors.darkBlue.withOpacity(0.4),
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(widget.category.imagePath),
              ),
            ),
          )
        ],
      ),
    );
  }
}
