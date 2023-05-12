import 'package:flutter/material.dart';
import 'package:esprit/SizeConfig.dart';
import 'package:esprit/components/custom_surfix_icon.dart';
import 'package:esprit/static.dart';
import 'package:esprit/constants.dart';
import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/components/default_button.dart';
import 'package:esprit/components/form_error.dart';
import 'package:esprit/src/utils/my_urls.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:esprit/screens/courses/laststep.dart';
import 'package:esprit/screens/profile/profile_screen.dart';

class PassScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            SizeConfig1().init(constraints, orientation);

            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: const Text('Update my user information'),
              ),
              backgroundColor: Colors.white,
              body: UpdatePassword(),
            );
          },
        );
      },
    );
  }
}

class UpdatePassword extends StatefulWidget {
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final List<String> errors = [];

  final _formKey = GlobalKey<FormState>();
  String password;
  String confirmpassword;
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

  static String url = '${MyUrls.serverUrl}/updatePass';
  void updatePassword() async {
    Map data = {"email": Userutils.email, "password": password};
    var body = json.encode(data);
    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);

      if (200 == response.statusCode) {
        ToastUtils.showCustomToast(context, "Password Changed Successfully");
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      } else {
        print("error");
      }
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: (30)),
          Text("Change your Password:",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: "muli",
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  fontSize: 2.8 * SizeConfig1.textMultiplier,
                  color: AppThemeColors.darkBlue)),
          SizedBox(height: (30)),
          buildPasswordFormField(),
          SizedBox(height: (30)),
          buildConfirmPassFormField(),
          FormError(errors: errors),
          SizedBox(height: (40)),
          DefaultButton(
            text: "Save",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                updatePassword();
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConfirmPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirmpassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == confirmpassword) {
          removeError(error: kMatchPassError);
        }
        confirmpassword = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => SignUp.password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter a new password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
