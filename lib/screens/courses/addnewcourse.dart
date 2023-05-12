import 'package:esprit/components/custom_surfix_icon.dart';
import 'package:esprit/components/default_button.dart';
import 'package:esprit/components/form_error.dart';
import 'package:esprit/constants.dart';
import 'package:esprit/size_config.dart';
import 'package:esprit/SizeConfig.dart';
import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:esprit/screens/courses/addnewcoursescreentwo.dart';

class AddnewForm extends StatefulWidget {
  @override
  _AddnewFormState createState() => _AddnewFormState();
}

class _AddnewFormState extends State<AddnewForm> {
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Column(children: [
        SizedBox(height: getProportionateScreenHeight(10)),
        Image.asset('assets/images/key.gif'),
        SizedBox(height: getProportionateScreenHeight(10)),
        Text("First step:",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "muli",
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 2.8 * SizeConfig1.textMultiplier,
                color: AppThemeColors.pureBlack)),
        Text('Enter a title:'),
        Text('Example: I will teach you how to code with Python'),
        SizedBox(height: getProportionateScreenHeight(10)),
        buildTitleFormField(),
        SizedBox(height: getProportionateScreenHeight(25)),
        buildDescriptionFormField(),
        FormError(errors: errors),
        SizedBox(height: getProportionateScreenHeight(20)),
        DefaultButton(
          text: "Continue to Step Two!",
          press: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              // if all are valid then go to success screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateNewCourseScreenTwo()),
              );
            }
          },
        ),
        SizedBox(height: getProportionateScreenHeight(15)),
      ]),
    ));
  }

  final List<String> errors = [];

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

  TextFormField buildTitleFormField() {
    return TextFormField(
      inputFormatters: [
        new LengthLimitingTextInputFormatter(40),
      ],
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => CourseUtils.title = newValue,
      onChanged: (value) {
        CourseUtils.title = value;
        if (value.isNotEmpty) {
          removeError(error: kTitleNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kTitleNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Title",
        hintText: "Start by giving your course a Title",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/title.svg"),
      ),
    );
  }

  TextFormField buildDescriptionFormField() {
    return TextFormField(
      inputFormatters: [
        new LengthLimitingTextInputFormatter(100),
      ],
      minLines:
          4, // any number you need (It works as the rows for the textarea)
      keyboardType: TextInputType.multiline,
      maxLines: null,
      onSaved: (newValue) => CourseUtils.description = newValue,
      onChanged: (value) {
        CourseUtils.description = value;
        if (value.isNotEmpty) {
          removeError(error: kDescriptionNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kDescriptionNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Description",
        hintText:
            "Start by giving a brief description\n about your Gig, for example:\n \"I offer python coding sessions\n for experts and beginners!\"",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/description.svg"),
      ),
    );
  }
}
