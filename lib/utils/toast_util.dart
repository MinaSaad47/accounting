part of 'utils.dart';

enum ToastLevel {
  success,
  warning,
  error,
}

void _toast(
  BuildContext context, {
  required String message,
  ToastLevel level = ToastLevel.success,
}) {
  const List<Color> colors = [
    Colors.green,
    Colors.orange,
    Colors.red,
  ];

  const List<IconData> icons = [
    Icons.message_outlined,
    Icons.warning_amber_outlined,
    Icons.error_outline,
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icons[level.index], color: Colors.white),
            const SizedBox(width: 5),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    ),
  );
}
