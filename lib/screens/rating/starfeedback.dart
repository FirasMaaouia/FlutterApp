import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:esprit/src/utils/my_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';
import 'package:esprit/static.dart';

class StarFeedback extends StatefulWidget {
  @override
  _StarFeedbackState createState() => _StarFeedbackState();
}

class _StarFeedbackState extends State<StarFeedback> {
  TextEditingController commentController = new TextEditingController();
  static Future<void> submitRating() async {
    var url = Uri.parse("${MyUrls.serverUrl}/courses/${RatingT.id}/rate");

    List<Map> rating = new List();

    Rating rat = new Rating(RatingT.value, Userutils.name);
    rating.add(rat.TojsonData());

    List<Map> comment = new List();
    Comment com = new Comment(RatingT.comment, Userutils.name);
    comment.add(com.TojsonData());

    var body = json.encode({"comment": comment, "rating": rating});
    String hey = body.toString();
    String result = hey.replaceAll("[", "");
    String result2 = result.replaceAll("]", "");
    body = result2;

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    String jsonsDataString = response.body.toString();
    print("result: " + jsonsDataString);
    if (response.statusCode == 200) {
      print('ok');
    } else {
      print("not ok");
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    print(RatingT.id);
    super.initState();
  }

  var myFeedbackText = "COULD BE BETTER";
  var sliderValue = 0.0;
  IconData myFeedback1 = FontAwesomeIcons.star,
      myFeedback2 = FontAwesomeIcons.star,
      myFeedback3 = FontAwesomeIcons.star,
      myFeedback4 = FontAwesomeIcons.star,
      myFeedback5 = FontAwesomeIcons.star;
  Color myFeedbackColor1 = Colors.grey,
      myFeedbackColor2 = Colors.grey,
      myFeedbackColor3 = Colors.grey,
      myFeedbackColor4 = Colors.grey,
      myFeedbackColor5 = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _myAppBar(),
          Container(
            color: Color(0xffE5E5E5),
            child: Column(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(66.0),
                    child: Container(
                        child: Text(
                      "On a scale of 1 to 5, how do you rate this course?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                SizedBox(height: 5.0),
                Container(
                  child: Align(
                    child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Color(0x802196F3),
                      child: Container(
                          width: 350.0,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: starWidget(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Slider(
                                    min: 0.0,
                                    max: 5.0,
                                    divisions: 5,
                                    value: sliderValue,
                                    activeColor: Color(0xffed1e79),
                                    inactiveColor: Colors.blueGrey,
                                    onChanged: (newValue) {
                                      setState(() {
                                        sliderValue = newValue;
                                        if (sliderValue == 1.0) {
                                          RatingT.value = 1;
                                          myFeedback1 =
                                              FontAwesomeIcons.solidStar;
                                          myFeedbackColor1 = Colors.yellow;
                                        } else if (sliderValue < 1.0) {
                                          myFeedback1 = FontAwesomeIcons.star;
                                          myFeedbackColor1 = Colors.grey;
                                        }
                                        if (sliderValue == 2.0) {
                                          RatingT.value = 2;
                                          myFeedback2 =
                                              FontAwesomeIcons.solidStar;
                                          myFeedbackColor2 = Colors.yellow;
                                        } else if (sliderValue < 2.0) {
                                          myFeedback2 = FontAwesomeIcons.star;
                                          myFeedbackColor2 = Colors.grey;
                                        }
                                        if (sliderValue == 3.0) {
                                          RatingT.value = 3;
                                          myFeedback3 =
                                              FontAwesomeIcons.solidStar;
                                          myFeedbackColor3 = Colors.yellow;
                                        } else if (sliderValue < 3.0) {
                                          myFeedback3 = FontAwesomeIcons.star;
                                          myFeedbackColor3 = Colors.grey;
                                        }
                                        if (sliderValue == 4.0) {
                                          RatingT.value = 4;
                                          myFeedback4 =
                                              FontAwesomeIcons.solidStar;
                                          myFeedbackColor4 = Colors.yellow;
                                        } else if (sliderValue < 4.0) {
                                          myFeedback4 = FontAwesomeIcons.star;
                                          myFeedbackColor4 = Colors.grey;
                                        }
                                        if (sliderValue == 5.0) {
                                          RatingT.value = 5;
                                          myFeedback5 =
                                              FontAwesomeIcons.solidStar;
                                          myFeedbackColor5 = Colors.yellow;
                                        } else if (sliderValue < 5.0) {
                                          myFeedback5 = FontAwesomeIcons.star;
                                          myFeedbackColor5 = Colors.grey;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                    child: Text(
                                  "Your Rating : $sliderValue",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  child: TextField(
                                    controller: commentController,
                                    decoration: new InputDecoration(
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.blueGrey)),
                                      hintText: 'Add a comment (optional)',
                                    ),
                                    style: TextStyle(height: 3.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    color: Color(0xffed1e79),
                                    child: Text(
                                      'Submit',
                                      style:
                                          TextStyle(color: Color(0xffffffff)),
                                    ),
                                    onPressed: () {
                                      RatingT.comment = commentController.text;
                                      submitRating();
                                      Navigator.pop(context);
                                    },
                                  ),
                                )),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  List<Widget> starWidget() {
    List<Widget> myContainer = new List();
    myContainer.add(Container(
        child: Icon(
      myFeedback1,
      color: myFeedbackColor1,
      size: 50.0,
    )));
    myContainer.add(Container(
        child: Icon(
      myFeedback2,
      color: myFeedbackColor2,
      size: 50.0,
    )));
    myContainer.add(Container(
        child: Icon(
      myFeedback3,
      color: myFeedbackColor3,
      size: 50.0,
    )));
    myContainer.add(Container(
        child: Icon(
      myFeedback4,
      color: myFeedbackColor4,
      size: 50.0,
    )));
    myContainer.add(Container(
        child: Icon(
      myFeedback5,
      color: myFeedbackColor5,
      size: 50.0,
    )));
    return myContainer;
  }

  Widget _myAppBar() {
    return Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            const Color(0xff144fFb),
            const Color(0xff144fFb),
          ],
          begin: Alignment.centerRight,
          end: new Alignment(-1.0, -1.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      //
                    }),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  'Rating',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.star,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //
                    }),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
