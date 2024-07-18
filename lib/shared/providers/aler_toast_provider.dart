import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum AlertType {
  success,
  error,
  info,
  warning,
}

final alertProvider = StateNotifierProvider<AlertNotifier, void>((ref) {
  return AlertNotifier();
});

class AlertNotifier extends StateNotifier<void> {
  AlertNotifier() : super(null);

  void showAlert({required String message, required AlertType alertType}) {
    Color backgroundColor;
    switch (alertType) {
      case AlertType.success:
        backgroundColor = Colors.green;
        break;
      case AlertType.error:
        backgroundColor = Colors.red;
        break;
      case AlertType.info:
        backgroundColor = Colors.blue;
        break;
      case AlertType.warning:
        backgroundColor = Colors.orange;
        break;
    }

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
