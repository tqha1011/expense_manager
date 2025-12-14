import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class DialogUtils {
  static void showLoadingDialog(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      barrierDismissible: false,
      disableBackBtn: true,
      width: 100,
    );
  }
  static void showSuccessDialog(BuildContext context, {String message = "Success"}) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: message,
      autoCloseDuration: Duration(seconds: 2),
      width: 200,
    );
  }

  static void showErrorDialog(BuildContext context, {String message = "An error occurred"}) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: message,
    );
  }

  static void switchLoadingToSuccess(BuildContext context, {String message = "Success"}) {
    Navigator.of(context).pop(); // Đóng dialog loading hiện tại
    showSuccessDialog(context, message: message);
  }

  static void switchLoadingToError(BuildContext context, {String message = "An error occurred"}) {
    Navigator.of(context).pop(); // Đóng dialog loading hiện tại
    showErrorDialog(context, message: message);
  }
}