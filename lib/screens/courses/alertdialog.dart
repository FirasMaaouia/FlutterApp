import 'package:flutter/material.dart';

enum alertDialogAction { cancel, save }

class Dialogs {
  static Future<alertDialogAction> alertDialog(
    BuildContext context,
    String title,
    String body,
    String cancel,
    String save,
  ) {
    Future<alertDialogAction> action = showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              FlatButton(
                  onPressed: () =>
                      Navigator.pop(context, alertDialogAction.cancel),
                  child: Text(cancel)),
              RaisedButton(
                  color: Colors.red,
                  onPressed: () =>
                      Navigator.of(context).pop(alertDialogAction.save),
                  child: Text(
                    save,
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          );
        });
    return (action != null) ? action : alertDialogAction.cancel;
  }
}
