import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DAppSnackBar {
  static final DAppSnackBar _instance = DAppSnackBar._internal();

  factory DAppSnackBar() {
    return _instance;
  }

  DAppSnackBar._internal() {}

  void showSuccessfulSnackBar(String message, BuildContext context) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).accentColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorSnackBar(String message, BuildContext context) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).errorColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
