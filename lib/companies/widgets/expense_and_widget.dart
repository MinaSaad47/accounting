import 'package:accounting/common/common.dart';
import 'package:accounting_api/accounting_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeWidget extends StatelessWidget {
  final IncomeModel income;
  final Function()? onDelete;
  final Function()? onEdit;
  const IncomeWidget({
    Key? key,
    required this.income,
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
                  minRadius: 15,
                  child: Icon(Icons.currency_exchange_outlined),
                ),
                const SizedBox(width: 5),
                Text(
                  '${income.value}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  minRadius: 15,
                  child: Icon(Icons.person_outline),
                ),
                const SizedBox(width: 5),
                Text(
                  income.adminName!,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  minRadius: 15,
                  child: Icon(Icons.date_range_outlined),
                ),
                const SizedBox(width: 5),
                Text(
                  DateFormat.MEd().format(income.time!),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
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
                  Text(
                    AppLocalizations.of(context)!.edit(''),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
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
                  const SizedBox(width: 2),
                  Text(
                    AppLocalizations.of(context)!.delete,
                  ),
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
              income.description,
              style: Theme.of(context).textTheme.labelMedium,
              maxLines: 3,
            ),
          ),
        )
      ],
    );
  }
}

class ExpenseWidget extends StatelessWidget {
  final ExpenseModel expense;
  final Function()? onDelete;
  final Function()? onEdit;
  const ExpenseWidget({
    Key? key,
    required this.expense,
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
                  minRadius: 15,
                  child: Icon(Icons.currency_exchange_outlined),
                ),
                const SizedBox(width: 5),
                Text(
                  '${expense.value}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  minRadius: 15,
                  child: Icon(Icons.person_outline),
                ),
                const SizedBox(width: 5),
                Text(
                  '${expense.userName}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  minRadius: 15,
                  child: Icon(Icons.date_range_outlined),
                ),
                const SizedBox(width: 5),
                Text(
                  DateFormat.MEd().format(expense.time!),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
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
                  Text(
                    AppLocalizations.of(context)!.edit(''),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
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
                  const SizedBox(width: 2),
                  Text(
                    AppLocalizations.of(context)!.delete,
                  ),
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
              expense.description,
              style: Theme.of(context).textTheme.labelMedium,
              maxLines: 3,
            ),
          ),
        )
      ],
    );
  }
}
