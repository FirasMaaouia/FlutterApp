import 'dart:async';
import 'package:esprit/Home/HomeScreen/AllCoursesUI.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class LoadingOne extends StatefulWidget {
  @override
  _LoadingOneState createState() => _LoadingOneState();
}

class _LoadingOneState extends State<LoadingOne> {
  @override
  void initState() {
    super.initState();
    navtimer();
  }

  void navtimer() async {
    Timer(Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CoursesView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
            child: SpinKitFoldingCube(
          color: Colors.white,
          size: 80.0,
        )));
  }
}
