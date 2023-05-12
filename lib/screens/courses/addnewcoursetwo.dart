import 'package:esprit/components/custom_surfix_icon.dart';
import 'package:esprit/components/default_button.dart';
import 'package:esprit/size_config.dart';
import 'package:esprit/SizeConfig.dart';
import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/static.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'laststep.dart';

class StepTwoForm extends StatefulWidget {
  @override
  _StepTwoFormState createState() => _StepTwoFormState();
}

class VagasDisponivei {
  // ignore: non_constant_identifier_names
  String v_n;
  // ignore: non_constant_identifier_names
  String v_id;

  // ignore: non_constant_identifier_names
  VagasDisponivei({this.v_n, this.v_id});

  @override
  String toString() {
    // ignore: unnecessary_brace_in_string_interps
    return '${v_n}';
  }
}

class _StepTwoFormState extends State<StepTwoForm> {
  List<VagasDisponivei> _vagasDisponiveis;

  VagasDisponivei selectedValue;

  @override
  void initState() {
    super.initState();
    _vagasDisponiveis = [
      VagasDisponivei(v_id: "1", v_n: "Coding"),
      VagasDisponivei(v_id: "2", v_n: "Marketing"),
      VagasDisponivei(v_id: "3", v_n: "Security"),
      VagasDisponivei(v_id: "4", v_n: "UI/UX Design"),
      VagasDisponivei(v_id: "5", v_n: "Programming & Tech"),
      VagasDisponivei(v_id: "6", v_n: "Digital Marketing"),
      VagasDisponivei(v_id: "7", v_n: "Business"),
      VagasDisponivei(v_id: "8", v_n: "Music & Audio"),
      VagasDisponivei(v_id: "9", v_n: "Fun & Lifestyle"),
      VagasDisponivei(v_id: "10", v_n: "Languages"),
    ];
  }

  final _formKey = GlobalKey<FormState>();
  final daysofWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final pricelist = [
    '10 TND',
    '15 TND',
    '20 TND',
    '25 TND',
    '30 TND',
    '35 TND',
    '40 TND',
    '45 TND',
    '50 TND'
  ];
  String type;
  String type2;
  String finaltype;
  String category;

  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Column(children: [
        SizedBox(height: getProportionateScreenHeight(10)),
        Image.asset(
          'assets/images/CourseExample.png',
          height: 125.0,
          width: 125.0,
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Text("Second Step:",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "muli",
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 2.8 * SizeConfig1.textMultiplier,
                color: AppThemeColors.pureBlack)),
        Text('Select your availability'),
        SizedBox(height: getProportionateScreenHeight(15)),
        Row(
          children: <Widget>[
            Text("     From:",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: "muli",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    fontSize: 2.2 * SizeConfig1.textMultiplier,
                    color: AppThemeColors.pureBlack)),
            Spacer()
          ],
        ),
        daysofweekWidget(),
        SizedBox(height: getProportionateScreenHeight(10)),
        Row(
          children: <Widget>[
            Text("     To:",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: "muli",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    fontSize: 2.2 * SizeConfig1.textMultiplier,
                    color: AppThemeColors.pureBlack)),
            Spacer()
          ],
        ),
        daysofweekWidget2(),
        SizedBox(height: getProportionateScreenHeight(20)),
        Text('Select your gig category:'),
        Row(
          children: <Widget>[
            Text("    Category:",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: "muli",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    fontSize: 2.2 * SizeConfig1.textMultiplier,
                    color: AppThemeColors.pureBlack)),
            Spacer()
          ],
        ),
        catWidget(),
        SizedBox(height: getProportionateScreenHeight(30)),
        DefaultButton(
          text: "Continue to Final Step!",
          press: () {
            finaltype = type + ' to ' + type2;
            CourseUtils.available = finaltype;

            if ((finaltype.length < 7) ||
                (finaltype == null) ||
                (category.length < 5) ||
                (category == null)) {
              _showToast(context);
            } else {
              CourseUtils.bprice = null;
              CourseUtils.bdesc = null;
              CourseUtils.bhours = null;
              CourseUtils.sprice = null;
              CourseUtils.sdesc = null;
              CourseUtils.shours = null;
              CourseUtils.pprice = null;
              CourseUtils.pdesc = null;
              CourseUtils.phours = null;

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LastStep()),
              );
            }
          },
        ),
        SizedBox(height: getProportionateScreenHeight(15)),
      ]),
    ));
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    // ignore: deprecated_member_use
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Please complete the form'),
        backgroundColor: Colors.red,
        action: SnackBarAction(
            textColor: Colors.white,
            label: 'Ok',
            // ignore: deprecated_member_use
            onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Widget daysofweekWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/date.svg"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text("Choose starting day"),
                value: type,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    type = newValue;
                  });
                },
                items: daysofWeek.map((String value) {
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

  Widget daysofweekWidget2() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/date.svg"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text("Choose ending day"),
                value: type2,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    type2 = newValue;
                  });
                },
                items: daysofWeek.map((String value) {
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

  Widget catWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SearchableDropdown(
            hint: Text('Which category your offer belongs to?'),
            items: _vagasDisponiveis.map((item) {
              return new DropdownMenuItem<VagasDisponivei>(
                  child: Text(item.v_n), value: item);
            }).toList(),
            isExpanded: true,
            value: selectedValue,
            isCaseSensitiveSearch: true,
            searchHint: new Text(
              'Pick a category: ',
              style: new TextStyle(fontSize: 20),
            ),
            onChanged: (value) {
              setState(() {
                selectedValue = value;
                category = selectedValue.toString();
                CourseUtils.category = category;
              });
            },
          ),
        ],
      ),
    );
  }
}
