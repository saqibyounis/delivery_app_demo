import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DAppDialog {
  static final DAppDialog _instance = DAppDialog._internal();

  factory DAppDialog() {
    return _instance;
  }

  DAppDialog._internal() {}

  void showYesNoDIalog(BuildContext context, Function onYesPressed) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text("Logout"),
              content: Text("Want to logout?"),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context);
                    onYesPressed();
                  },
                  isDefaultAction: true,
                  child: Text("Yes"),
                ),
                CupertinoDialogAction(
                  onPressed: () => Navigator.pop(context),
                  child: Text("No"),
                )
              ],
            ));
  }
}
