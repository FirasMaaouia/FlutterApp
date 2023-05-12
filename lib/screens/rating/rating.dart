import 'package:flutter/material.dart';
import 'package:esprit/screens/rating/starfeedback.dart';
import 'service.dart';
import 'outputmodel.dart';

class Ratings extends StatefulWidget {
  Ratings({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RatingsState createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  List<Myratings> _feed;
  List<Comment> comments;
  List<Rating> ratings;
  String img;
  int length;
  @override
  void initState() {
    super.initState();

    Service.getRatings().then((ratings) {
      setState(() {
        _feed = ratings;
        length = ratings.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: BluePainter(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Ratings for this course",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: "muli",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 25.8,
                      color: Colors.white)),
              SingleChildScrollView(
                  child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 40,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: null == _feed ? 0 : _feed.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .20,
                                      child: ListView.separated(
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return SizedBox(
                                              width: 20,
                                            );
                                          },
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: null == _feed
                                              ? 0
                                              : _feed[index].ratings.length,
                                          itemBuilder: (context, countryIndex) {
                                            String xd = _feed[index]
                                                .comments[countryIndex]
                                                .content;
                                            if (xd == null) {
                                              xd = "";
                                            }
                                            img = _feed[index]
                                                .ratings[countryIndex]
                                                .value
                                                .toString();
                                            switch (img) {
                                              case ('5'):
                                                img = "assets/images/5star.png";
                                                break;
                                              case ('4'):
                                                img = "assets/images/5star.png";
                                                break;
                                              case ('3'):
                                                img = "assets/images/3star.png";
                                                break;
                                              case ('2'):
                                                img = "assets/images/2star.png";
                                                break;
                                              case ('1'):
                                                img = "assets/images/1star.png";
                                                break;
                                            }
                                            print(_feed[index].ratings.length);
                                            if (_feed[index].ratings.length ==
                                                null) {
                                              return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      width: 120,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Text(
                                                              "No courses found!",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "muli",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  letterSpacing:
                                                                      1.2,
                                                                  fontSize:
                                                                      25.8,
                                                                  color: Colors
                                                                      .white)),
                                                        ],
                                                      ),
                                                    )
                                                  ]);
                                            } else {
                                              return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      width: 120,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Text(
                                                            _feed[index]
                                                                .ratings[
                                                                    countryIndex]
                                                                .ratedBy,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Image.asset(
                                                            img,
                                                            width: 100,
                                                            height: 60,
                                                          ),
                                                          Text(
                                                            xd,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ]);
                                            }
                                          }),
                                    ),
                                  )
                                ])
                          ],
                        );
                      }))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StarFeedback()));
        },
        label: const Text('Rate this course'),
        icon: const Icon(
          Icons.thumb_up,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.blue.shade700;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    // Start paint from 20% height to the left
    ovalPath.moveTo(0, height * 0.2);

    // paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(
        width * 0.45, height * 0.25, width * 0.51, height * 0.5);

    // Paint a curve from current position to bottom left of screen at width * 0.1
    ovalPath.quadraticBezierTo(width * 0.58, height * 0.8, width * 0.1, height);

    // draw remaining line to bottom left side
    ovalPath.lineTo(0, height);

    // Close line to reset it back
    ovalPath.close();

    paint.color = Colors.blue.shade600;
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
