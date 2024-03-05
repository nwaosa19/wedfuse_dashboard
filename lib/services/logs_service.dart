import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/loading_indicator.dart';

Future<void> addLog(BuildContext context, {
  required String action,
  required String detail,
  required String enforcer,
  required String role,
  required DateTime date,
}) async {
  try {
    // Show loading indicator
    showLoadingDialog(context);

    await FirebaseFirestore.instance.collection('logs').add({
      'action': action,
      'enforcer': enforcer,
      'date': date,
      'role': role,
      "detail": detail
    }).then((value) => Navigator.pop(context));
  } catch (error) {
    // Handle errors (e.g., show an error message)
    print('Error adding suspension: $error');
  }
}
