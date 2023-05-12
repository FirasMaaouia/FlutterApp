import 'package:esprit/src/data/models/custom_error.dart';
import 'package:esprit/src/data/models/user.dart';
import 'package:esprit/src/data/repositories/register_repository.dart';
import 'package:esprit/src/utils/custom_shared_prefs.dart';
import 'package:esprit/src/utils/state_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:esprit/static.dart';
import 'package:email_auth/email_auth.dart';
import 'package:esprit/screens/otp/otp_screen.dart';

class RegisterController extends StateControl {
  final BuildContext context;

  RegisterRepository _registerRepository = RegisterRepository();

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isFormValid = false;
  get isFormValid => _isFormValid;

  bool _formSubmitting = false;
  get formSubmitting => _formSubmitting;

  RegisterController({
    @required this.context,
  }) {
    this.init();
  }

  void init() {}

  void submitForm() async {
    _formSubmitting = true;
    notifyListeners();
    String name = SignUp.fullname;
    String username = SignUp.username;
    String email = SignUp.email;
    String password = SignUp.password;
    String type = SignUp.type;

    var loginResponse = await _registerRepository.register(
        name, email, username, password, type);
    if (loginResponse is CustomError) {
      showAlertDialog(loginResponse.errorMessage);
    } else if (loginResponse is User) {
      await CustomSharedPreferences.setString('user', loginResponse.toString());
      sendOtp();
      Navigator.pushNamed(context, OtpScreen.routeName);
    }
    _formSubmitting = false;
    notifyListeners();
  }

  ///a void funtion to send the OTP to the user
  void sendOtp() async {
    EmailAuth.sessionName = "Learnly Mobile App";
    bool result = await EmailAuth.sendOtp(receiverMail: SignUp.email);
    if (result) {
      print("Code Sent to:" + SignUp.email);
    }
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
      title: Text("Errors"),
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

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
}
