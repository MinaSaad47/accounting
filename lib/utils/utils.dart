import 'package:accounting/common/common.dart';
import 'package:accounting/login/cubit/login_cubit.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'logger_util.dart';
part 'toast_util.dart';
part 'formater.dart';
part 'admin_do.dart';

class Utils {
  static get log => _log;
  static void toast(
    BuildContext context, {
    required String message,
    ToastLevel level = ToastLevel.success,
  }) =>
      _toast(context, message: message, level: level);

  static String formatDate(DateTime dt) => _formatDate(dt);

  static void adminDo(
    BuildContext context, {
    bool password = true,
    required void Function() fn,
  }) =>
      _adminDo(context, fn: fn, requirePassword: password);
}
