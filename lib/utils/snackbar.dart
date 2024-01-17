import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3), // You can adjust the duration
  );

  // Display the SnackBar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  // Adjust the pattern based on your formatting needs
}

String formatTime(DateTime time) {
  return DateFormat('HH:mm:ss').format(time);
  // Adjust the pattern based on your formatting needs
}
