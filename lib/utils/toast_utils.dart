import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showMessage(String? message) {
  if (message != null) {
    Fluttertoast.showToast(msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

showSuccessMessage(String? message) {
  if (message != null) {
    Fluttertoast.showToast(msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}