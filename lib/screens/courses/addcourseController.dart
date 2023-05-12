import 'package:esprit/src/data/models/custom_error.dart';
import 'package:esprit/src/data/repositories/course_repository.dart';
import 'package:esprit/src/utils/state_control.dart';
import 'package:esprit/static.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseController extends StateControl {
  CourseRepository _courseRepository = CourseRepository();

  final BuildContext context;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isFormValid = false;
  get isFormValid => _isFormValid;

  bool _formSubmitting = false;
  get formSubmitting => _formSubmitting;

  CourseController({
    @required this.context,
  }) {
    this.init();
  }

  void init() {
    this.emailController.addListener(this.validateForm);
    this.passwordController.addListener(this.validateForm);
  }

  @override
  void dispose() {
    super.dispose();
    this.emailController.dispose();
    this.passwordController.dispose();
  }

  void submitForm1() async {
    _formSubmitting = true;
    notifyListeners();
    String title = CourseEdit.title;
    String title1 = CourseEdit.title;
    String description = CourseEdit.description;
    String category = CourseEdit.category;
    String available = CourseEdit.available;
    String bprice = CourseEdit.bprice;
    String bdesc = CourseEdit.bdesc;
    String bhours = CourseEdit.bhours;
    String sprice = CourseEdit.sprice;
    String sdesc = CourseEdit.sdesc;
    String shours = CourseEdit.shours;
    String pprice = CourseEdit.pprice;
    String pdesc = CourseEdit.pdesc;
    String phours = CourseEdit.phours;

    var loginResponse = await _courseRepository.editCourse(
        title,
        title1,
        description,
        category,
        available,
        bprice,
        bdesc,
        bhours,
        sprice,
        sdesc,
        shours,
        pprice,
        pdesc,
        phours);
    if (loginResponse is CustomError) {
      showAlertDialog(loginResponse.errorMessage);
    } else {
      print(loginResponse);
    }
    _formSubmitting = false;
    notifyListeners();
  }

  void submitForm() async {
    _formSubmitting = true;
    notifyListeners();
    String title = CourseUtils.title;
    String description = CourseUtils.description;
    String usermail = CourseUtils.usermail;
    String category = CourseUtils.category;
    String available = CourseUtils.available;
    String bprice = CourseUtils.bprice;
    String bdesc = CourseUtils.bdesc;
    String bhours = CourseUtils.bhours;
    String sprice = CourseUtils.sprice;
    String sdesc = CourseUtils.sdesc;
    String shours = CourseUtils.shours;
    String pprice = CourseUtils.pprice;
    String pdesc = CourseUtils.pdesc;
    String phours = CourseUtils.phours;
    String imagepath = Userutils.email + ".png";
    String name = Userutils.name;
    String rating = "0.0";
    var loginResponse = await _courseRepository.addCourse(
        title,
        description,
        usermail,
        category,
        available,
        bprice,
        bdesc,
        bhours,
        sprice,
        sdesc,
        shours,
        pprice,
        pdesc,
        phours,
        rating,
        imagepath,
        name);
    if (loginResponse is CustomError) {
      showAlertDialog(loginResponse.errorMessage);
    } else {
      print(loginResponse);
    }
    _formSubmitting = false;
    notifyListeners();
  }

  void validateForm() {
    bool isFormValid = _isFormValid;
    String email = this.emailController.value.text;
    String password = this.passwordController.value.text;
    if (email.trim() == "" || password.trim() == "") {
      isFormValid = false;
    } else {
      isFormValid = true;
    }
    _isFormValid = isFormValid;
    notifyListeners();
  }

  showAlertDialog(String message) {
    // configura o button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Error!"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}
