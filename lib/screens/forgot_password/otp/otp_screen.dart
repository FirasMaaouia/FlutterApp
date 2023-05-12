import 'package:flutter/material.dart';
import 'package:esprit/size_config.dart';

import 'components/body.dart';

class ForgotScreen extends StatelessWidget {
  static String routeName = "/otpscreen";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("OTP Verification"),
      ),
      body: Body(),
    );
  }
}
