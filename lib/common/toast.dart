import 'package:flutter/material.dart';

enum ToastLevel {
  success,
  warning,
  error,
}

void showToast(
  BuildContext context, {
  required String message,
  ToastLevel level = ToastLevel.success,
}) {
  const List<Color> colors = [
    Colors.green,
    Colors.yellow,
    Colors.red,
  ];
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.all(20.0),
      elevation: 20.0,
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      backgroundColor: colors[level.index],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      content: Center(
        heightFactor: double.minPositive,
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    ),
  );
}
