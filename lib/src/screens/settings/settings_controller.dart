import 'dart:io';
import 'package:esprit/screens/sign_in/sign_in_screen.dart';
import 'package:esprit/src/data/models/user.dart';
import 'package:esprit/src/data/providers/chats_provider.dart';
import 'package:esprit/src/data/repositories/user_repository.dart';
import 'package:esprit/src/utils/custom_shared_prefs.dart';
import 'package:esprit/src/utils/socket_controller.dart';
import 'package:esprit/src/utils/state_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SettingsController extends StateControl {
  final BuildContext context;

  UserRepository _userRepository = UserRepository();

  IO.Socket socket = SocketController.socket;

  User myUser;

  SettingsController({
    @required this.context,
  }) {
    this.init();
  }

  void init() {
    getMyUser();
  }

  getMyUser() async {
    myUser = await CustomSharedPreferences.getMyUser();
    notifyListeners();
  }

  openModalDeleteChats() {
    String title = "Remove all conversations?";
    String description = "No going back from This!";
    List<Widget> actions = [
      TextButton(
        child: Text(Platform.isIOS ? 'Cancel' : 'Cancel'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      TextButton(
        child: Text(
          Platform.isIOS ? 'Submit' : 'Continue',
          style: TextStyle(color: Platform.isIOS ? Colors.red : Colors.blue),
        ),
        onPressed: () {
          Navigator.pop(context);
          deleteChats();
        },
      ),
    ];
    showAlertDialog(title, description, actions);
  }

  deleteChats() async {
    await Provider.of<ChatsProvider>(context, listen: false).clearDatabase();
    String title = "Success";
    String description = "All conversations are deleted!";
    List<Widget> actions = [
      TextButton(
        child: Text(Platform.isIOS ? 'Ok' : 'OK'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ];
    showAlertDialog(title, description, actions);
  }

  openModalExitApp() {
    String title = "Logout";
    String description = "Are you sure you want to logout?";
    List<Widget> actions = [
      TextButton(
        child: Text(Platform.isIOS ? 'Cancel' : 'Cancel'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      TextButton(
        child: Text(
          Platform.isIOS ? 'Exit' : 'Logout',
          style: TextStyle(color: Platform.isIOS ? Colors.red : Colors.blue),
        ),
        onPressed: () {
          Navigator.pop(context);
          logout();
        },
      ),
    ];
    showAlertDialog(title, description, actions);
  }

  showAlertDialog(String title, String description, List<Widget> actions) {
    var alertDialog;
    if (Platform.isIOS) {
      alertDialog = CupertinoAlertDialog(
        title: Text(title),
        content: Text(description),
        actions: actions,
      );
    } else {
      alertDialog = AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: actions,
      );
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  void emitUserLeft() async {
    socket.emit("user-left");
  }

  logout() async {
    emitUserLeft();
    _userRepository.saveUserFcmToken(null);
    await CustomSharedPreferences.remove('user');
    await CustomSharedPreferences.remove('token');
    Provider.of<ChatsProvider>(context, listen: false).clearDatabase();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(SignInScreen.routeName, (_) => false);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
