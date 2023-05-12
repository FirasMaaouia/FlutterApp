import 'package:esprit/static.dart';
import 'package:flutter/material.dart';
import 'package:esprit/components/custom_surfix_icon.dart';
import 'package:esprit/components/default_button.dart';
import 'package:esprit/components/form_error.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:esprit/src/screens/register/register_controller.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  final professionTypes = ['Learner', "Teacher"];

  RegisterController _registerController;

  @override
  void initState() {
    super.initState();
    SignUp.check = "no";
    _registerController = RegisterController(context: context);
  }

  @override
  void dispose() {
    _registerController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFullNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildUsernameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          ProfessionWidget(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Confirm Registration",
            press: () {
              if (_formKey.currentState.validate()) {
                _registerController.submitForm();
              }
            },
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ProfessionWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                suffixIcon:
                    CustomSurffixIcon(svgIcon: "assets/icons/Star Icon.svg"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text("Choose your profession"),
                value: SignUp.type,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    SignUp.type = newValue;
                  });
                },
                items: professionTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      onSaved: (newValue) => SignUp.username = newValue,
      onChanged: (value) {
        SignUp.username = value;
        if (value.isNotEmpty) {
          removeError(error: kUsernameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kUsernameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "Enter your username",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/username.svg"),
      ),
    );
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      onSaved: (newValue) => SignUp.fullname = newValue,
      onChanged: (value) {
        SignUp.fullname = value;
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
        labelText: "Full Name",
        hintText: "Enter your full name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
