import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

errorSnackBar(String message, context) {
  final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
              child: Text(message,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.redAccent);

  SchedulerBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
}

successSnackBar(String message, context) {
  final snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      content: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
              child: Text(message,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green);

  SchedulerBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
}
