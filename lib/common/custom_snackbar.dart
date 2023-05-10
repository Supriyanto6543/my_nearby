import 'dart:developer';

import 'package:flutter/material.dart';

enum SnackMode { error, success, warning }

class CustomSnackBar {
  static displaySnackBar(BuildContext _, SnackMode mode, String text,
      {int dur = 15, SnackBarAction? action}) {
    Color backgroundColor;

    if (mode == SnackMode.error) {
      backgroundColor = const Color(0xFFF11617);
    } else if (mode == SnackMode.success) {
      backgroundColor = const Color(0xFF12B669);
    } else {
      backgroundColor = Color.fromARGB(255, 252, 244, 9);
    }

    final snackBar = SnackBar(
      content: Text(
        text,
        style: Theme.of(_).textTheme.bodyLarge!.copyWith(
              color: mode == SnackMode.warning ? Colors.black : Colors.white,
            ),
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: dur),
      action: action ??
          SnackBarAction(
            label: 'close',
            textColor: mode == SnackMode.warning ? Colors.black : Colors.white,
            onPressed: () {
              try {
                ScaffoldMessenger.of(_).hideCurrentSnackBar();
              } catch (e) {
                log('Snackbar cannot be closed due to different context');
              }
            },
          ),
    );

    ScaffoldMessenger.of(_).clearSnackBars();
    ScaffoldMessenger.of(_).showSnackBar(snackBar);
  }
}
