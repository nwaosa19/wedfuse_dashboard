import 'package:flutter/material.dart';

Future<void> showLoadingDialog(
  BuildContext context, {
  String? message = 'Loading...',
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap button!
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false, // Prevent accidental back button pop
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              Text(message!),
            ],
          ),
        ),
      );
    },
  );
}

void hideLoadingDialog(BuildContext context) {
  Navigator.of(context).pop();
}
