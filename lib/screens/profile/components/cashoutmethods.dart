import 'package:flutter/material.dart';
import 'package:esprit/static.dart';
import '../../../size_config.dart';
import 'section_title.dart';
import 'cashinfo.dart';

class CashoutMethods extends StatefulWidget {
  const CashoutMethods({
    Key key,
  }) : super(key: key);

  @override
  _CashoutMethodsState createState() => _CashoutMethodsState();
}

class _CashoutMethodsState extends State<CashoutMethods> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Available Cashout Methods:",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CashoutCard(
                image: "assets/images/edinar.jpg",
                category: "Carte E Dinar",
                waittime: "Up to 24 hours",
                press: () {
                  Cashout.paymentmethod = "Carte E Dinar";
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CashoutInfo()));
                },
              ),
              CashoutCard(
                image: "assets/images/sobflous.png",
                category: "Sobflous",
                waittime: "Up to 48 hours",
                press: () {
                  Cashout.paymentmethod = "Sobflous";
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CashoutInfo()));
                },
              ),
              CashoutCard(
                image: "assets/images/D17.png",
                category: "D17 DigiPost",
                waittime: "Up to 24 hours",
                press: () {
                  Cashout.paymentmethod = "D17 DigiPost";
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CashoutInfo()));
                },
              ),
              CashoutCard(
                image: "assets/images/paymee.png",
                category: "Paymee.tn",
                waittime: "Up to 48 hours",
                press: () {
                  Cashout.paymentmethod = "Paymee.tn";
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CashoutInfo()));
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}

class CashoutCard extends StatelessWidget {
  const CashoutCard({
    Key key,
    @required this.category,
    @required this.image,
    @required this.waittime,
    @required this.press,
  }) : super(key: key);

  final String category, image;
  final String waittime;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(222),
          height: getProportionateScreenWidth(150),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Material(
                    child: InkWell(
                  onTap: () {},
                  child: Container(
                    child: ClipRRect(
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.3),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "Estimated:  "),
                        TextSpan(text: "$waittime ")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
