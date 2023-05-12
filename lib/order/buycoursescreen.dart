import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/SizeConfig.dart';
import 'package:esprit/components/custom_surfix_icon.dart';
import 'package:esprit/components/default_button.dart';
import 'package:esprit/screens/courses/laststep.dart';
import 'package:esprit/order/paymentmethods.dart';
import 'package:esprit/static.dart';

class BuyScreen extends StatefulWidget {
  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  double _height;
  double _width;

  String mydate;
  String mytime;
  String package;
  String first, last;
  String _time;
  dynamic currentTime = DateFormat.jm().format(DateTime.now());
  String dateTime;

  final packageType = ['Basic Plan', 'Standard Plan', 'Premium Plan'];
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1);

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  int mon, tue, wed, thu, fri, sat, sun;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        selectableDayPredicate: (DateTime val) => val.weekday == mon ||
                val.weekday == tue ||
                val.weekday == wed ||
                val.weekday == thu ||
                val.weekday == fri ||
                val.weekday == sat ||
                val.weekday == sun
            ? false
            : true,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: new DateTime(DateTime.now().year),
        lastDate: new DateTime(DateTime.now().year + 1));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        mydate = selectedDate
            .toString()
            .substring(0, selectedDate.toString().indexOf(' '));
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        mytime = selectedTime.toString().substring(10, 15);
        _time = mytime;
        _timeController.text = _time;
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());
    _timeController.text = currentTime;
    mon = 0;
    tue = 0;
    wed = 0;
    thu = 0;
    fri = 0;
    sat = 0;
    sun = 0;
    first =
        CourseOrder.available.substring(0, CourseOrder.available.indexOf(' '));

    last = CourseOrder.available.replaceAll(first + " to ", '');
    print(first);
    print(last);
    if ((first == "Monday") && (last == "Tuesday")) {
      wed = 3;
      thu = 4;
      fri = 5;
      sat = 6;
      sun = 7;
    } else if ((first == "Monday") && (last == "Wednesday")) {
      thu = 4;
      fri = 5;
      sat = 6;
      sun = 7;
    } else if ((first == "Monday") && (last == "Thursday")) {
      mon = 0;
      tue = 0;
      wed = 0;
      fri = 5;
      sat = 6;
      sun = 7;
    } else if ((first == "Monday") && (last == "Friday")) {
      sat = 6;
      sun = 7;
    } else if ((first == "Monday") && (last == "Saturday")) {
      sun = 7;
    } else if ((first == "Tuesday") && (last == "Wednesday")) {
      mon = 1;
      thu = 4;
      fri = 5;
      sat = 6;
      sun = 7;
    } else if ((first == "Tuesday") && (last == "Thursday")) {
      mon = 1;
      fri = 5;
      sat = 6;
      sun = 7;
    } else if ((first == "Tuesday") && (last == "Friday")) {
      mon = 1;
      sat = 6;
      sun = 7;
    } else if ((first == "Tuesday") && (last == "Saturday")) {
      mon = 1;
      sun = 7;
    } else if ((first == "Tuesday") && (last == "Sunday")) {
      mon = 1;
    } else if ((first == "Wednesday") && (last == "Thursday")) {
      mon = 1;
      tue = 2;
      fri = 5;
      sat = 6;
      sun = 7;
    } else if ((first == "Wednesday") && (last == "Friday")) {
      mon = 1;
      tue = 2;
      sat = 6;
      sun = 7;
    } else if ((first == "Wednesday") && (last == "Saturday")) {
      mon = 1;
      tue = 2;
      sun = 7;
    } else if ((first == "Wednesday") && (last == "Sunday")) {
      mon = 1;
      tue = 2;
    } else if ((first == "Thursday") && (last == "Friday")) {
      mon = 1;
      tue = 2;
      wed = 3;
      sat = 6;
      sun = 7;
    } else if ((first == "Thursday") && (last == "Saturday")) {
      mon = 1;
      tue = 2;
      wed = 3;
      sun = 7;
    } else if ((first == "Thursday") && (last == "Sunday")) {
      mon = 1;
      tue = 2;
      wed = 3;
    } else if ((first == "Thursday") && (last == "Monday")) {
      tue = 2;
      wed = 3;
    } else if ((first == "Friday") && (last == "Saturday")) {
      mon = 1;
      tue = 2;
      wed = 3;
      thu = 4;
      sun = 7;
    } else if ((first == "Friday") && (last == "Sunday")) {
      mon = 1;
      tue = 2;
      wed = 3;
      thu = 4;
    } else if ((first == "Friday") && (last == "Monday")) {
      tue = 2;
      wed = 3;
      thu = 4;
    } else if ((first == "Friday") && (last == "Tuesday")) {
      wed = 3;
      thu = 4;
    } else if ((first == "Friday") && (last == "Wednesday")) {
      thu = 4;
    } else if ((first == "Saturday") && (last == "Sunday")) {
      mon = 1;
      tue = 2;
      wed = 3;
      thu = 4;
      fri = 5;
    } else if ((first == "Saturday") && (last == "Monday")) {
      tue = 2;
      wed = 3;
      thu = 4;
      fri = 5;
    } else if ((first == "Saturday") && (last == "Tuesday")) {
      wed = 3;
      thu = 4;
      fri = 5;
    } else if ((first == "Saturday") && (last == "Wednesday")) {
      thu = 4;
      fri = 5;
    } else if ((first == "Saturday") && (last == "Thursday")) {
      fri = 5;
    } else if ((first == "Sunday") && (last == "Monday")) {
      tue = 2;
      wed = 3;
      thu = 4;
      fri = 5;
      sat = 6;
    } else if ((first == "Sunday") && (last == "Tuesday")) {
      wed = 3;
      thu = 4;
      fri = 5;
      sat = 6;
    } else if ((first == "Sunday") && (last == "Wednesday")) {
      thu = 4;
      fri = 5;
      sat = 6;
    } else if ((first == "Sunday") && (last == "Thursday")) {
      fri = 5;
      sat = 6;
    } else if ((first == "Sunday") && (last == "Friday")) {
      sat = 6;
    } else if (first == last) {
      mon = 0;
      tue = 0;
      wed = 0;
      thu = 0;
      fri = 0;
      sat = 0;
    } else {
      mon = 0;
      tue = 0;
      wed = 0;
      thu = 0;
      fri = 0;
      sat = 0;
    }
    print(mon);
    print(tue);
    print(wed);
    print(thu);
    print(fri);
    print(sat);
    print(sun);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Fill in required information'),
      ),
      body: Container(
        width: _width,
        height: _height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 15),
            Text("Select when you want to start learning this course",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "muli",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 2.8 * SizeConfig1.textMultiplier,
                    color: AppThemeColors.darkBlue)),
            SizedBox(height: 35),
            Column(
              children: <Widget>[
                Text(
                  'Choose Starting Date:',
                  style: TextStyle(
                      color: AppThemeColors.pureBlack,
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    width: _width / 1.8,
                    height: _height / 12,
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue[500],
                        borderRadius: BorderRadius.all(
                          Radius.circular(7.0),
                        )),
                    child: TextFormField(
                      style: TextStyle(
                        color: AppThemeColors.nearlyWhite,
                        fontSize: 34,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dateController,
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.only(top: 0.0)),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'Choose Starting Time:',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: AppThemeColors.pureBlack,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    width: _width / 1.8,
                    height: _height / 12,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue[500],
                      borderRadius: BorderRadius.all(Radius.circular(
                              7.0) //                 <--- border radius here
                          ),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        color: AppThemeColors.nearlyWhite,
                        fontSize: 34,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeController,
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Text("Select your package:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "muli",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        fontSize: 2.8 * SizeConfig1.textMultiplier,
                        color: AppThemeColors.darkBlue)),
                SizedBox(height: 35),
                packageWidget(),
                SizedBox(height: 55),
                DefaultButton(
                  text: "Continue to Payment",
                  press: () {
                    if ((package == null) ||
                        (mydate == null) ||
                        (mytime == null)) {
                      ToastUtils.showCustomToast(
                          context, "Please fill in required information!");
                    } else {
                      CourseOrder.startdate = mydate;
                      CourseOrder.starttime = mytime;
                      CourseOrder.chosenpackage = package;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentMethods()));
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget packageWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/box.svg"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text("Choose your Package"),
                value: package,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    package = newValue;
                  });
                },
                items: packageType.map((String value) {
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
}
