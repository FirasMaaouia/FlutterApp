import 'package:flutter/material.dart';
import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/SizeConfig.dart';
import 'package:esprit/static.dart';
import 'package:esprit/components/custom_surfix_icon.dart';
import 'package:esprit/components/default_button.dart';
import 'package:esprit/components/form_error.dart';
import '../../../constants.dart';
import 'package:esprit/screens/courses/alertdialog.dart';
import 'package:esprit/screens/courses/laststep.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:esprit/src/utils/my_urls.dart';
import 'package:esprit/screens/profile/profile_screen.dart';

class CashoutInfo extends StatefulWidget {
  @override
  _CashoutInfoState createState() => new _CashoutInfoState();
}

var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

class _CashoutInfoState extends State<CashoutInfo> {
  final List<String> errors = [];
  String image;
  void initState() {
    Cashout.cashinfo = null;
    if (Cashout.paymentmethod == "Paymee.tn") {
      image = "assets/images/paymee.png";
    } else if (Cashout.paymentmethod == "D17 DigiPost") {
      image = "assets/images/D17.png";
    } else if (Cashout.paymentmethod == "Carte E Dinar") {
      image = "assets/images/edinar.jpg";
    } else {
      image = "assets/images/sobflous.png";
    }
    super.initState();
  }

  static Future<void> requestCashout() async {
    var url = Uri.parse("${MyUrls.serverUrl}/createCashout");

    Map data = {
      'sendermail': Userutils.email,
      'sendername': Userutils.name,
      'chosengateway': Cashout.paymentmethod,
      'gatewayinfo': Cashout.cashinfo,
      'balance': Userutils.balance
    };
    var body = json.encode(data);

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    String jsonsDataString = response.body.toString();
    // toString of Response's body is assigned to jsonDataString
    data = jsonDecode(jsonsDataString);
    if (response.statusCode == 200) {
      print('ok');
    }
  }

  static Future<void> updateUserBalance() async {
    var url = Uri.parse("${MyUrls.serverUrl}/updateBalance");

    Map data = {'email': Userutils.email, 'balance': 0};
    var body = json.encode(data);

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    String jsonsDataString = response.body.toString();
    // toString of Response's body is assigned to jsonDataString
    data = jsonDecode(jsonsDataString);
    if (response.statusCode == 200) {
      print('updated');
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text("Please fill in required information."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog1(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text("Credit card number should be 16 digits!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog2(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text("Balance is below 50 TND! Come back later"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fill in required Information",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.6,
                  fontSize: 2.3 * SizeConfig1.textMultiplier,
                  color: AppThemeColors.darkBlue)),
        ),
        body: new SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30),
              Image.asset(image),
              SizedBox(height: 30),
              Text(" Cashout Method:",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "muli",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 2.8 * SizeConfig1.textMultiplier,
                      color: AppThemeColors.darkBlue)),
              Text("${Cashout.paymentmethod}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "muli",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 2.8 * SizeConfig1.textMultiplier,
                      color: AppThemeColors.darkBlue)),
              SizedBox(height: 40),
              Text("Please enter your ${Cashout.paymentmethod} details: ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "muli",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 2.8 * SizeConfig1.textMultiplier,
                      color: AppThemeColors.darkBlue)),
              SizedBox(height: 30),
              buildForm(),
              FormError(errors: errors),
              SizedBox(height: 30),
              DefaultButton(
                  text: "Confirm and send",
                  press: () async {
                    if ((Cashout.paymentmethod == "Carte E Dinar") &&
                        (Cashout.cashinfo == null)) {
                      showAlertDialog(context);
                    } else if ((Cashout.paymentmethod == "Carte E Dinar") &&
                        (Cashout.cashinfo.length != 16)) {
                      showAlertDialog1(context);
                    } else if (Cashout.cashinfo == null) {
                      showAlertDialog(context);
                    } else if (Userutils.balance <= 50) {
                      showAlertDialog2(context);
                    } else {
                      final action = await Dialogs.alertDialog(
                          context,
                          "Requesting Cashout",
                          "You sure you can to continue filing this cashout?",
                          "Cancel",
                          "Continue");
                      //cancel and save are the button text for cancel and save operation
                      if (action == alertDialogAction.save) {
                        ToastUtils.showCustomToast(
                            context, "Cashout Request Succesffuly Added");
                        requestCashout();
                        updateUserBalance();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()));
                      }
                    }
                  }),
            ],
          ),
        ));
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  TextFormField buildForm() {
    if ((Cashout.paymentmethod == "Sobflous") ||
        (Cashout.paymentmethod == "Paymee.tn")) {
      return TextFormField(
        onSaved: (newValue) => Cashout.cashinfo = newValue,
        onChanged: (value) {
          Cashout.cashinfo = value;
          if (value.isNotEmpty) {
            removeError(error: kNamelNullError);
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            addError(error: kNamelNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "Enter your ${Cashout.paymentmethod} email",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/email1.svg"),
        ),
      );
    } else if (Cashout.paymentmethod == "D17 DigiPost") {
      return TextFormField(
        keyboardType: TextInputType.number,
        onSaved: (newValue) => Cashout.cashinfo = newValue,
        onChanged: (value) {
          Cashout.cashinfo = value;
          if (value.isNotEmpty) {
            removeError(error: kNamelNullError);
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            addError(error: kNamelNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "D17 DigiPost Phone Number:",
          hintText: "Enter your ${Cashout.paymentmethod} Phone Number",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/telephone.svg"),
        ),
      );
    } else {
      return TextFormField(
        keyboardType: TextInputType.number,
        onSaved: (newValue) => Cashout.cashinfo = newValue,
        onChanged: (value) {
          Cashout.cashinfo = value;
          if (value.isNotEmpty) {
            removeError(error: kNamelNullError);
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            addError(error: kNamelNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Carte E Dinar Number:",
          hintText: "Enter your ${Cashout.paymentmethod} Number",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:
              CustomSurffixIcon(svgIcon: "assets/icons/credit-card.svg"),
        ),
      );
    }
  }
}
