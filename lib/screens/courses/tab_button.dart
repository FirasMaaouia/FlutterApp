import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TabButton extends StatelessWidget {
  String name;
  int selectedPage;
  int pageNumber;
  Function onTap;
  TabButton(
      {@required this.name,
      @required this.selectedPage,
      @required this.pageNumber,
      @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        padding: EdgeInsets.symmetric(
            vertical: 6, horizontal: selectedPage == pageNumber ? 24 : 8),
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            color:
                selectedPage == pageNumber ? Colors.white : Colors.blueAccent,
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          name,
          style: TextStyle(
              color: selectedPage == pageNumber ? Colors.blue : Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
