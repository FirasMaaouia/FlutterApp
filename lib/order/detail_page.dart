import 'package:esprit/order/ordermodel.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Order order;
  DetailPage({Key key, this.order}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String image;
  Color color = Colors.blue;
  @override
  void initState() {
    image = "assets/images/basic.png";
    changePic();
    super.initState();
  }

  void changePic() {
    if (widget.order.senderpackage == "Premium Plan") {
      image = "assets/images/premium.png";
      color = Colors.orange;
    } else if (widget.order.senderpackage == "Standard Plan") {
      image = "assets/images/standard.png";
      color = Colors.green;
    } else {
      color = Colors.blue;
      image = "assets/images/basic.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: Image.asset(
          image,
          width: 40.0,
          height: 40.0,
        ),
      ),
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.5)),
      child: new Text(
        widget.order.totalprice.toString() + " TND",
        style: TextStyle(color: Colors.white),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 50.0),
        Image.asset(
          "assets/images/hat.png",
          width: 40.0,
          height: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          widget.order.coursetitle,
          style: TextStyle(color: Colors.white, fontSize: 25.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 5,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "${widget.order.senderpackage}",
                      style:
                          TextStyle(color: color, fontWeight: FontWeight.bold),
                    ))),
            Expanded(flex: 3, child: coursePrice)
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/summary.jpg"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 116, .75)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            "Order Summary:",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            child: Container(
              color: Colors.black,
              height: 220.0,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            height: 100.0,
                            width: double.infinity,
                            child: Text(
                                'Teacher Email:\n ${widget.order.courseemail}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Muli")),
                          ),
                        ),
                        SizedBox(height: 2),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            height: 100.0,
                            width: double.infinity,
                            child: Text(
                              'Purchase date:\n ${widget.order.date} at ${widget.order.time}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Muli"),
                            ),
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          color: Colors.white,
                          height: 50.0,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Start date: ${widget.order.startdate}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Muli"),
                              ),
                              Text(
                                'Start time: ${widget.order.starttime}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Muli"),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          color: Colors.blue[100],
                          height: 50.0,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Teacher Status:\n ${widget.order.teacherstatus}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Muli"),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
