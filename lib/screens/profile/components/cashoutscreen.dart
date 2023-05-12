import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'balance.dart';
import 'cashoutmethods.dart';
import 'section_title.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(30)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SectionTitle(
                title: "Current Balance:",
                press: () {},
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Balance(),
            CashoutMethods(),
            SizedBox(height: getProportionateScreenWidth(30)),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
