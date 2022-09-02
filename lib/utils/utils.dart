import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

part 'logger_util.dart';
part 'toast_util.dart';
part 'formater.dart';

class Utils {
  static get log => _log;
  static void toast(
    BuildContext context, {
    required String message,
    ToastLevel level = ToastLevel.success,
  }) =>
      _toast(context, message: message);

  static String formatDate(DateTime dt) => _formatDate(dt);
}
