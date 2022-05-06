import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum MessageType { error, success }

extension ContextExtension on BuildContext {
  hideKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }

  bool get isTablet {
    var shortestSide = MediaQuery.of(this).size.shortestSide;
    return shortestSide >= 600;
  }

  double get paddingTop => MediaQuery.of(this).padding.top;

  TextStyle textStyle({
    Color? color,
  }) {
    return Theme.of(this).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.normal, color: color);
  }

  showMessage(
    String? message, {
    MessageType type = MessageType.success,
  }) {
    FToast fToast;
    fToast = FToast();
    fToast.init(this);
    Color bg;
    switch (type) {
      case MessageType.error:
        bg = Colors.red;
        break;
      case MessageType.success:
        bg = Colors.green;
        break;
    }
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: bg,
      ),
      child: Text(message ?? '',textAlign: TextAlign.center, style: const TextStyle(color: Colors.white),),
    );
    fToast.removeCustomToast();
    fToast.showToast(
      child: toast,
      positionedToastBuilder: (context, child) {
        return Positioned(child: child, bottom: 150, left: 24.0, right: 24.0);
      },
      toastDuration: const Duration(seconds: 2),
    );
  }
}

extension NavigatorStateExtension on NavigatorState {
  void pushNamedIfNotCurrent(String routeName, {Object? arguments}) {
    if (!isCurrent(routeName)) {
      pushNamed(routeName, arguments: arguments);
    }
  }

  bool isCurrent(String routeName) {
    bool isCurrent = false;
    popUntil((route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }
}
