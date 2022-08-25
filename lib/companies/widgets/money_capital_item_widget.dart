import 'package:accounting/common/common.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoneyCapitalItemWidget extends StatelessWidget {
  final MoneyCapitalModel moneyCapital;
  final Function()? onDelete;
  final Function()? onEdit;
  const MoneyCapitalItemWidget({
    Key? key,
    required this.moneyCapital,
    this.onDelete,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                    child: Icon(Icons.currency_exchange_outlined)),
                const SizedBox(width: 5),
                Text('${moneyCapital.value}'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(child: Icon(Icons.person_outline)),
                const SizedBox(width: 5),
                Text('${moneyCapital.userName}'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(child: Icon(Icons.date_range_outlined)),
                const SizedBox(width: 5),
                Text(DateFormat.MEd().format(moneyCapital.time!)),
              ],
            ),
          ),
          if (onEdit != null)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: onEdit,
              child: Row(
                children: [
                  const Icon(Icons.edit_outlined),
                  const SizedBox(width: 4),
                  Text(AppLocalizations.of(context)!.edit('')),
                ],
              ),
            ),
          if (onDelete != null) ...[
            const SizedBox(width: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.error,
              ),
              onPressed: onDelete,
              child: Row(
                children: [
                  const Icon(Icons.delete_outline),
                  const SizedBox(width: 4),
                  Text(AppLocalizations.of(context)!.delete),
                ],
              ),
            ),
          ]
        ],
      ),
      childrenPadding: const EdgeInsets.all(20),
      children: [
        Center(
          child: ListTile(
            leading: const Icon(Icons.description_outlined),
            title: Text(
              moneyCapital.description,
              style: Theme.of(context).textTheme.headline5,
              maxLines: 3,
            ),
          ),
        )
      ],
    );
  }
}
