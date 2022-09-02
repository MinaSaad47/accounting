part of 'utils.dart';

String _formatDate(DateTime date, {String locale = 'ara_EG'}) {
  final format = DateFormat.yMMMd(locale);
  return format.format(date);
}
