import 'package:flutter/material.dart';

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
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Row(
              children: [
                const SizedBox(width: 5),
                Icon(
                  icon,
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
                ),
                const SizedBox(width: 5),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
