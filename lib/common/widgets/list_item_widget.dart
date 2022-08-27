import 'package:accounting/common/common.dart';
import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  final List<Widget> labels;
  final String title;
  final Function()? onPressed;
  const ListItemWidget({
    Key? key,
    required this.labels,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).primaryColor, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          Row(
            children: [
              const Spacer(),
              if (onPressed != null)
                MaterialButton(
                  onPressed: onPressed,
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.displayMore,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.info_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                )
            ],
          ),
          for (var label in labels) ...[label, const SizedBox(height: 10)]
        ],
      ),
    );
  }
}
