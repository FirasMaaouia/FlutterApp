import 'package:flutter/material.dart';
import 'package:esprit/components/custom_surfix_icon.dart';
import 'package:esprit/components/default_button.dart';
import 'package:esprit/components/form_error.dart';
import 'package:esprit/constants.dart';
import 'package:flutter/services.dart';
import 'package:im_stepper/stepper.dart';
import 'package:esprit/size_config.dart';
import 'package:esprit/SizeConfig.dart';
import 'package:esprit/static.dart';
import 'package:esprit/screens/courses/laststep.dart';
import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:esprit/screens/courses/addcourseController.dart';
import 'package:esprit/screens/courses/coursesRoute.dart';

class EditCourse extends StatefulWidget {
  @override
  _EditCourse createState() => _EditCourse();
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

class _EditCourse extends State<EditCourse> {
  final _formKey = GlobalKey<FormState>();
  List<VagasDisponivei> _vagasDisponiveis;

  VagasDisponivei selectedValue;
  double _currentSliderValue;

  double _currentSliderValue1;
  double _currentSliderValue2;
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

    _pageController = PageController();
    _courseController = CourseController(context: context);
    bprice = 0;
    sprice = 0;
    pprice = 0;
    bpricey = bpricee.toDouble();
    spricey = spricee.toDouble();
    ppricey = ppricee.toDouble();
    _currentSliderValue = bpricey;
    _currentSliderValue1 = spricey;
    _currentSliderValue2 = ppricey;
    bprice = bpricee;
    sprice = spricee;
    pprice = ppricee;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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

  int activeStep = 0; // Initial step set to 5.

  int upperBound = 3; // upperBound MUST BE total number of icons minus 1.

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  CourseController _courseController;
  int bprice, sprice, pprice;

  PageController _pageController;
  double bpricey;
  double spricey;
  double ppricey;
  int bpricee = int.parse(CourseEdit.bprice);
  int spricee = int.parse(CourseEdit.sprice);
  int ppricee = int.parse(CourseEdit.pprice);

  final hourslist = [
    '1 Hour',
    '2 Hours',
    '3 Hours',
    '4 Hours',
    '5 Hours',
    '6 Hours',
    '7 Hours',
    '8 Hours',
    '9 Hours',
    '10 Hours',
    '11 Hours',
    '20 Hours',
    '21 Hours',
    '22 Hours',
    '23 Hours',
    '24 Hours',
    '25 Hours'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit your course'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            IconStepper(
              icons: [
                Icon(Icons.title),
                Icon(Icons.event_available),
                Icon(Icons.attach_money),
                Icon(Icons.done_all_sharp),
              ],

              // activeStep property set to activeStep variable defined above.
              activeStep: activeStep,

              // This ensures step-tapping updates the activeStep.
              onStepReached: (index) {
                setState(() {
                  activeStep = index;
                });
              },
            ),
            header(),
            myWidget(),
          ],
        ),
      ),
    );
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

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
      child: Text('Next'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Text('Prev'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Availability';

      case 2:
        return 'Price, Category & Package Description';

      case 3:
        return 'Image';

      default:
        return 'Title and Description';
    }
  }

  Widget myWidget() {
    switch (activeStep) {
      case 1:
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
                CourseEdit.available = finaltype;

                if ((finaltype.length < 7) ||
                    (finaltype == null) ||
                    (category.length < 5) ||
                    (category == null)) {
                  _showToast(context);
                } else {
                  CourseEdit.bprice = null;
                  CourseEdit.bdesc = null;
                  CourseEdit.bhours = null;
                  CourseEdit.sprice = null;
                  CourseEdit.sdesc = null;
                  CourseEdit.shours = null;
                  CourseEdit.pprice = null;
                  CourseEdit.pdesc = null;
                  CourseEdit.phours = null;
                  if (activeStep < upperBound) {
                    setState(() {
                      activeStep++;
                    });
                  }
                }
              },
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
          ]),
        ));

      case 2:
        return SingleChildScrollView(
            child: Form(
          key: _formKey3,
          child: Column(children: [
            SizedBox(height: getProportionateScreenHeight(10)),
            cxnews(),
            SizedBox(height: getProportionateScreenHeight(25)),
            cxnews1(),
            SizedBox(height: getProportionateScreenHeight(20)),
            cxnews2(),
            SizedBox(height: getProportionateScreenHeight(15)),
          ]),
        ));

      case 3:
        return Text("3");

      default:
        return SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(children: [
            SizedBox(height: 20),
            Image.asset('assets/images/key.gif'),
            SizedBox(height: 20),
            SizedBox(height: getProportionateScreenHeight(10)),
            buildTitleFormField(),
            SizedBox(height: getProportionateScreenHeight(25)),
            buildDescriptionFormField(),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(20)),
            DefaultButton(
              text: "Continue To Availability",
              press: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  // if all are valid then go to success screen
                  if (activeStep < upperBound) {
                    setState(() {
                      activeStep++;
                    });
                  }
                }
              },
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
          ]),
        ));
    }
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
      initialValue: "${CourseEdit.title}",
      onSaved: (newValue) => CourseEdit.title = newValue,
      onChanged: (value) {
        CourseEdit.title = value;
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
      initialValue: "${CourseEdit.description}",
      onSaved: (newValue) => CourseEdit.description = newValue,
      onChanged: (value) {
        CourseEdit.description = value;
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
                CourseEdit.category = category;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget cxnews() {
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Column(children: [
        SizedBox(height: getProportionateScreenHeight(25)),
        Text("Basic Package Price:",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "muli",
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 2.8 * SizeConfig1.textMultiplier,
                color: AppThemeColors.pureBlack)),
        SizedBox(height: getProportionateScreenHeight(10)),
        buildPriceFormField(),
        Text(bprice.toString() + " TND",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "muli",
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 2.8 * SizeConfig1.textMultiplier,
                color: AppThemeColors.darkBlue)),
        SizedBox(height: getProportionateScreenHeight(25)),
        Text("Basic Package Description:",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "muli",
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 2.8 * SizeConfig1.textMultiplier,
                color: AppThemeColors.pureBlack)),
        SizedBox(height: getProportionateScreenHeight(25)),
        buildDescriptionFormField22(),
        SizedBox(height: getProportionateScreenHeight(25)),
        Text("Basic Package Hours:",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "muli",
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 2.8 * SizeConfig1.textMultiplier,
                color: AppThemeColors.pureBlack)),
        SizedBox(height: getProportionateScreenHeight(25)),
        basichours(),
        SizedBox(height: getProportionateScreenHeight(10)),
        FormError(errors: errors),
      ]),
    ));
  }

  int price;
  Widget buildPriceFormField() {
    return Slider(
      value: _currentSliderValue,
      min: 0,
      max: 500,
      divisions: 50,
      label: _currentSliderValue.round().toString() + " TND",
      onChanged: (double value) {
        setState(() {
          bprice = value.toInt();
          _currentSliderValue = value;
          price = _currentSliderValue.toInt();
          CourseEdit.bprice = price.toString();
        });
      },
    );
  }

  Widget basichours() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                suffixIcon:
                    CustomSurffixIcon(svgIcon: "assets/icons/clock.svg"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text("Basic package hours"),
                value: CourseEdit.bhours,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    CourseEdit.bhours = newValue;
                  });
                },
                items: hourslist.map((String value) {
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

  Widget basichours1() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                suffixIcon:
                    CustomSurffixIcon(svgIcon: "assets/icons/clock.svg"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text("Standard package hours"),
                value: CourseEdit.shours,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    CourseEdit.shours = newValue;
                  });
                },
                items: hourslist.map((String value) {
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

  Widget basichours2() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                suffixIcon:
                    CustomSurffixIcon(svgIcon: "assets/icons/clock.svg"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text("Premium package hours"),
                value: CourseEdit.phours,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    CourseEdit.phours = newValue;
                  });
                },
                items: hourslist.map((String value) {
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

  TextFormField buildDescriptionFormField22() {
    return TextFormField(
      inputFormatters: [
        new LengthLimitingTextInputFormatter(100),
      ],
      minLines:
          4, // any number you need (It works as the rows for the textarea)
      keyboardType: TextInputType.multiline,
      maxLines: null,
      initialValue: CourseEdit.bdesc,
      onSaved: (newValue) => CourseEdit.bdesc = newValue,
      onChanged: (value) {
        CourseEdit.bdesc = value;
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
        labelText: "Basic Description",
        hintText:
            "Start by giving a brief description\n about your Basic Gig, example:\n \"I will teach you how\n to create two Mobile UI Screens\"",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/description.svg"),
      ),
    );
  }

  Widget cxnews1() {
    return SingleChildScrollView(
        child: Form(
      key: _formKey1,
      child: Column(children: [
        SizedBox(height: getProportionateScreenHeight(25)),
        Text("Standard Package Price:",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "muli",
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 2.8 * SizeConfig1.textMultiplier,
                color: AppThemeColors.pureBlack)),
        SizedBox(height: getProportionateScreenHeight(10)),
        buildSPriceFormField(),
        Text(sprice.toString() + " TND",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "muli",
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 2.8 * SizeConfig1.textMultiplier,
                color: AppThemeColors.darkBlue)),
        SizedBox(height: getProportionateScreenHeight(25)),
        Text("Standard Package Description:",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "muli",
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 2.8 * SizeConfig1.textMultiplier,
                color: AppThemeColors.pureBlack)),
        SizedBox(height: getProportionateScreenHeight(25)),
        buildDescriptionFormField1(),
        SizedBox(height: getProportionateScreenHeight(25)),
        Text("Standard Package Hours:",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "muli",
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 2.8 * SizeConfig1.textMultiplier,
                color: AppThemeColors.pureBlack)),
        SizedBox(height: getProportionateScreenHeight(25)),
        basichours1(),
        FormError(errors: errors),
      ]),
    ));
  }

  int price1;
  Widget buildSPriceFormField() {
    return Slider(
      value: _currentSliderValue1,
      min: 0,
      max: 500,
      divisions: 50,
      label: _currentSliderValue1.round().toString() + " TND",
      onChanged: (double value) {
        setState(() {
          sprice = value.toInt();
          _currentSliderValue1 = value;
          price1 = _currentSliderValue1.toInt();
          CourseEdit.sprice = price1.toString();
        });
      },
    );
  }

  TextFormField buildDescriptionFormField1() {
    return TextFormField(
      inputFormatters: [
        new LengthLimitingTextInputFormatter(100),
      ],
      minLines:
          4, // any number you need (It works as the rows for the textarea)
      keyboardType: TextInputType.multiline,
      maxLines: null,
      initialValue: CourseEdit.sdesc,
      onSaved: (newValue) => CourseEdit.sdesc = newValue,
      onChanged: (value) {
        CourseEdit.sdesc = value;
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
        labelText: "Standard Description",
        hintText:
            "Start by giving a brief description\n about your Standard Gig\n, example: \"I will teach you how\n to create five Mobile UI Screens\"",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/description.svg"),
      ),
    );
  }

  Widget cxnews2() {
    return SingleChildScrollView(
        child: Form(
      key: _formKey2,
      child: Column(children: [
        SizedBox(height: getProportionateScreenHeight(25)),
        Text("Premium Package Price:",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "muli",
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 2.8 * SizeConfig1.textMultiplier,
                color: AppThemeColors.pureBlack)),
        SizedBox(height: getProportionateScreenHeight(10)),
        buildPPriceFormField(),
        Text(pprice.toString() + " TND",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "muli",
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 2.8 * SizeConfig1.textMultiplier,
                color: AppThemeColors.darkBlue)),
        SizedBox(height: getProportionateScreenHeight(25)),
        Text("Premium Package Description:",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "muli",
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 2.8 * SizeConfig1.textMultiplier,
                color: AppThemeColors.pureBlack)),
        SizedBox(height: getProportionateScreenHeight(25)),
        buildDescriptionFormField2(),
        SizedBox(height: getProportionateScreenHeight(25)),
        Text("Premium Package Hours:",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "muli",
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 2.8 * SizeConfig1.textMultiplier,
                color: AppThemeColors.pureBlack)),
        SizedBox(height: getProportionateScreenHeight(25)),
        basichours2(),
        FormError(errors: errors),
        SizedBox(height: getProportionateScreenHeight(30)),
        DefaultButton(
          text: "Validate and Edit Course",
          press: () {
            if ((CourseEdit.bprice == null) ||
                (CourseEdit.bdesc == null) ||
                (CourseEdit.bhours == null) ||
                (CourseEdit.sprice == null) ||
                (CourseEdit.sdesc == null) ||
                (CourseEdit.shours == null) ||
                (CourseEdit.pprice == null) ||
                (CourseEdit.pdesc == null) ||
                (CourseEdit.phours == null)) {
              ToastUtils.showCustomToast(context, "Please fill all fields !");
            } else {
              _courseController.submitForm1();
              ToastUtils.showCustomToast(
                  context, "Course Edited successfully!");
              Navigator.pushNamed(context, CoursesScreen.routeName);
            }
          },
        ),
      ]),
    ));
  }

  int price2;
  Widget buildPPriceFormField() {
    return Slider(
      value: _currentSliderValue2,
      min: 0,
      max: 500,
      divisions: 50,
      label: _currentSliderValue2.round().toString() + " TND",
      onChanged: (double value) {
        setState(() {
          pprice = value.toInt();
          _currentSliderValue2 = value;
          price2 = _currentSliderValue2.toInt();
          CourseEdit.pprice = price2.toString();
        });
      },
    );
  }

  TextFormField buildDescriptionFormField2() {
    return TextFormField(
      inputFormatters: [
        new LengthLimitingTextInputFormatter(100),
      ],
      minLines:
          4, // any number you need (It works as the rows for the textarea)
      keyboardType: TextInputType.multiline,
      maxLines: null,
      initialValue: CourseEdit.pdesc,
      onSaved: (newValue) => CourseEdit.pdesc = newValue,
      onChanged: (value) {
        CourseEdit.pdesc = value;
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
        labelText: "Premium Description",
        hintText:
            "Start by giving a brief description\n about your Premium Gig\n, example: \"I will teach you how\n to create Ten Mobile UI Screens\"",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/description.svg"),
      ),
    );
  }
}
