import 'package:accounting/common/common.dart';
import 'package:accounting/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextLabelWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  const TextLabelWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const SizedBox(width: 5),
                Icon(
                  icon,
                  color: Theme.of(context).appBarTheme.foregroundColor,
                ),
                const SizedBox(width: 5),
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).appBarTheme.foregroundColor,
                      ),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              content,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: content)).then((value) {
                Utils.toast(
                  context,
                  message: l10n.clipboard(content),
                );
              });
            },
            icon: const Icon(
              Icons.copy_outlined,
            ),
            color: Theme.of(context).primaryColor,
            hoverColor: Theme.of(context).colorScheme.inversePrimary,
          ),
        ],
      ),
    );
  }
}
