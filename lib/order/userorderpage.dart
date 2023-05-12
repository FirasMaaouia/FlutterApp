import 'package:esprit/order/ordermodel.dart';
import 'package:flutter/material.dart';
import 'package:esprit/order/detail_page.dart';
import 'package:esprit/order/orderServices.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Order> _orders;

  int length;
  @override
  void initState() {
    super.initState();

    Service.getOrders().then((orders) {
      setState(() {
        _orders = orders;
        length = orders.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(order) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.black))),
            child: Image.asset(
              "assets/images/payment.gif",
              width: 40,
              height: 40,
            ),
          ),
          title: Text(
            order.coursetitle,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    // tag: 'hero',
                    child: LinearProgressIndicator(
                        backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                        value: 100,
                        valueColor: AlwaysStoppedAnimation(Colors.green)),
                  )),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(order.orderstatus,
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold))),
              )
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.blue[900], size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(order: order)));
          },
        );

    Card makeCard(Order order) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, .9)),
            child: makeListTile(order),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: null == _orders ? 0 : _orders.length,
        itemBuilder: (context, index) {
          Order order = _orders[index];
          return makeCard(order);
        },
      ),
    );

    final topAppBar = AppBar(
      elevation: 0.1,
      automaticallyImplyLeading: false,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      title: Text('My Orders'),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      appBar: topAppBar,
      body: makeBody,
    );
  }
}
