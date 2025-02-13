import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> notify(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar(); // Hide the existing one

  return messenger.showSnackBar(
    SnackBar(
      backgroundColor: Colors.blue,
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      ),
      duration: const Duration(seconds: 2),
    )
  );
}