import 'dart:async';
import 'dart:math';
import 'package:hb_check_code/hb_check_code.dart';
import 'package:esprit/components/default_button.dart';
import 'package:esprit/screens/courses/addcourseController.dart';
import 'package:esprit/screens/courses/updatecoursepic.dart';
import 'package:flutter/material.dart';
import 'tab_button.dart';
import 'package:esprit/components/custom_surfix_icon.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:esprit/components/form_error.dart';
import 'package:esprit/constants.dart';
import 'package:esprit/size_config.dart';
import 'package:esprit/SizeConfig.dart';
import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/static.dart';
import 'package:flutter/services.dart';

class LastStep extends StatefulWidget {
  @override
  _LastStepState createState() => _LastStepState();
}

class _LastStepState extends State<LastStep> {
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  CourseController _courseController;
  int bprice, sprice, pprice;
  int _selectedPage = 0;
  String captcha;
  PageController _pageController;
  double _currentSliderValue = 20;
  double _currentSliderValue1 = 20;
  double _currentSliderValue2 = 20;
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
  void _changePage(int page) {
    setState(() {
      _selectedPage = page;
      _pageController.animateToPage(page,
          duration: Duration(milliseconds: 1800),
          curve: Curves.fastLinearToSlowEaseIn);
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    _courseController = CourseController(context: context);
    bprice = 0;
    sprice = 0;
    pprice = 0;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Step'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            new Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              direction: Axis.horizontal, // main axis (rows or columns)
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TabButton(
                        name: 'Basic',
                        pageNumber: 0,
                        selectedPage: _selectedPage,
                        onTap: () => _changePage(0),
                      ),
                      TabButton(
                        name: 'Standard',
                        pageNumber: 1,
                        selectedPage: _selectedPage,
                        onTap: () => _changePage(1),
                      ),
                      TabButton(
                        name: 'Premium',
                        pageNumber: 2,
                        selectedPage: _selectedPage,
                        onTap: () => _changePage(2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
                child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _selectedPage = page;
                });
              },
              children: [
                cxnews(),
                cxnews1(),
                cxnews2(),
              ],
            ))
          ],
        ),
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
        buildDescriptionFormField(),
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
          CourseUtils.bprice = price.toString();
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
                value: CourseUtils.bhours,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    CourseUtils.bhours = newValue;
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
                value: CourseUtils.shours,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    CourseUtils.shours = newValue;
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
                value: CourseUtils.phours,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    CourseUtils.phours = newValue;
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

  TextFormField buildDescriptionFormField() {
    return TextFormField(
      inputFormatters: [
        new LengthLimitingTextInputFormatter(100),
      ],
      minLines:
          4, // any number you need (It works as the rows for the textarea)
      keyboardType: TextInputType.multiline,
      maxLines: null,
      onSaved: (newValue) => CourseUtils.bdesc = newValue,
      onChanged: (value) {
        CourseUtils.bdesc = value;
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
          CourseUtils.sprice = price1.toString();
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
      onSaved: (newValue) => CourseUtils.sdesc = newValue,
      onChanged: (value) {
        CourseUtils.sdesc = value;
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
    String code = "";
    for (var i = 0; i < 6; i++) {
      code = code + Random().nextInt(9).toString();
    }
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
        Column(
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Center(
                      child: HBCheckCode(
                    code: code,
                  )),
                ),
                InkWell(
                    onTap: () {
                      setState(() {});
                    },
                    child: Icon(Icons.refresh_rounded)),
              ],
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildCaptchaForm(),
        SizedBox(height: getProportionateScreenHeight(30)),
        DefaultButton(
          text: "Validate and add course",
          press: () {
            if ((CourseUtils.bprice == null) ||
                (CourseUtils.bdesc == null) ||
                (CourseUtils.bhours == null) ||
                (CourseUtils.sprice == null) ||
                (CourseUtils.sdesc == null) ||
                (CourseUtils.shours == null) ||
                (CourseUtils.pprice == null) ||
                (CourseUtils.pdesc == null) ||
                (CourseUtils.phours == null)) {
              ToastUtils.showCustomToast(context, "Please fill all fields !");
            } else if (captcha != code) {
              ToastUtils.showCustomToast(context, "Incorrect Captcha Code!");
              setState(() {});
            } else {
              _courseController.submitForm();
              ToastUtils.showCustomToast(context, "Course Added successfully!");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CourseUpload()),
              );
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
          CourseUtils.pprice = price2.toString();
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
      onSaved: (newValue) => CourseUtils.pdesc = newValue,
      onChanged: (value) {
        CourseUtils.pdesc = value;
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

  TextFormField buildCaptchaForm() {
    return TextFormField(
      inputFormatters: [
        new LengthLimitingTextInputFormatter(50),
      ],
      minLines:
          1, // any number you need (It works as the rows for the textarea)

      onChanged: (value) {
        captcha = value;
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
        labelText: "Captcha Code",
        hintText: "Enter the captcha code above!",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/description.svg"),
      ),
    );
  }
}

class ToastMessageAnimation extends StatelessWidget {
  final Widget child;

  ToastMessageAnimation(this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("translateY")
          .add(
            Duration(milliseconds: 250),
            Tween(begin: -100.0, end: 0.0),
            curve: Curves.easeOut,
          )
          .add(Duration(seconds: 1, milliseconds: 250),
              Tween(begin: 0.0, end: 0.0))
          .add(Duration(milliseconds: 250), Tween(begin: 0.0, end: -100.0),
              curve: Curves.easeIn),
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0))
          .add(Duration(seconds: 1), Tween(begin: 1.0, end: 1.0))
          .add(Duration(milliseconds: 500), Tween(begin: 1.0, end: 0.0)),
    ]);

    return ControlledAnimation(
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]), child: child),
      ),
    );
  }
}

class ToastUtils {
  static Timer toastTimer;
  static OverlayEntry _overlayEntry;

  static void showCustomToast(BuildContext context, String message) {
    if (toastTimer == null || !toastTimer.isActive) {
      _overlayEntry = createOverlayEntry(context, message);
      Overlay.of(context).insert(_overlayEntry);
      toastTimer = Timer(Duration(seconds: 2), () {
        if (_overlayEntry != null) {
          _overlayEntry.remove();
        }
      });
    }
  }

  static OverlayEntry createOverlayEntry(BuildContext context, String message) {
    return OverlayEntry(
        builder: (context) => Positioned(
              top: 50.0,
              width: MediaQuery.of(context).size.width - 20,
              left: 10,
              child: ToastMessageAnimation(Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 10),
                  decoration: BoxDecoration(
                      color: Color(0xffe53e3f),
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              )),
            ));
  }
}
