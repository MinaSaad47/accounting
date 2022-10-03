import 'package:accounting/common/common.dart';
import 'package:accounting/login/cubit/login_cubit.dart';
import 'package:accounting_api/accounting_api.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomeWidget extends StatelessWidget {
  final IncomeModel income;
  final Function()? onDelete;
  const IncomeWidget({
    Key? key,
    required this.income,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    var user = context.read<LoginCubit>().state.user;
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
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
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                AvatarGlow(
                  glowColor: Theme.of(context).primaryColor,
                  showTwoGlows: true,
                  animate: user?.name == income.adminName,
                  endRadius: 30,
                  child: const Material(
                    elevation: 8,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      maxRadius: 15,
                      child: Icon(Icons.person_outline),
                    ),
                  ),
                ),
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
                    l10n.delete,
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
  const ExpenseWidget({
    Key? key,
    required this.expense,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    var user = context.read<LoginCubit>().state.user;
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
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
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                AvatarGlow(
                  glowColor: Theme.of(context).primaryColor,
                  showTwoGlows: true,
                  animate: user?.name == expense.userName,
                  endRadius: 30,
                  child: const Material(
                    elevation: 8,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      maxRadius: 15,
                      child: Icon(Icons.person_outline),
                    ),
                  ),
                ),
                Text(
                  expense.userName!,
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
          if (onDelete != null) ...[
            const SizedBox(width: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.error,
              ),
              onPressed: user?.name == expense.userName ? onDelete : null,
              child: Row(
                children: [
                  const Icon(Icons.delete_outline),
                  const SizedBox(width: 2),
                  Text(
                    l10n.delete,
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
