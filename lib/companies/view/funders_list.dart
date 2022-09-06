import 'package:accounting/companies/bloc/funder_bloc.dart';
import 'package:accounting/utils/utils.dart';
import 'package:accounting_api/accounting_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FundersList extends StatelessWidget {
  const FundersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FunderBloc, FunderState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.status == FunderStatus.loading)
                const LinearProgressIndicator(),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      _BuildFunderItem(state.list[index]),
                  itemCount: state.list.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BuildFunderItem extends StatelessWidget {
  final FunderModel funder;
  const _BuildFunderItem(this.funder, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.person_outline),
                const SizedBox(width: 10),
                Text(funder.name),
              ],
            ),
            IconButton(
              onPressed: () => Utils.adminDo(context, () {
                context
                    .read<FunderBloc>()
                    .add(FunderDeleteRequested(funder.id!));
              }),
              icon: Icon(
                Icons.delete_forever_outlined,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
