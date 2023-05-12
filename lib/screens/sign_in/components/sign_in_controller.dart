import 'package:esprit/Home/HomeScreen/home.dart';
import 'package:esprit/src/data/models/custom_error.dart';
import 'package:esprit/src/data/models/user.dart';
import 'package:esprit/src/data/repositories/login_repository.dart';
import 'package:esprit/src/utils/state_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInController extends StateControl {
  LoginRepository _loginRepository = LoginRepository();

  final BuildContext context;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isFormValid = false;
  get isFormValid => _isFormValid;

  bool _formSubmitting = false;
  get formSubmitting => _formSubmitting;

  SignInController({
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

  void submitForm() async {
    _formSubmitting = true;
    notifyListeners();
    String email = this.emailController.value.text;
    String password = this.passwordController.value.text;
    var loginResponse = await _loginRepository.login(email, password);
    if (loginResponse is CustomError) {
      showAlertDialog(loginResponse.errorMessage);
    } else if (loginResponse is User) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
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
