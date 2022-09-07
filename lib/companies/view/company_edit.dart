import 'package:accounting/common/common.dart';
import 'package:accounting/companies/companies.dart';
import 'package:accounting/companies/widgets/company_widget.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyEdit extends StatefulWidget {
  const CompanyEdit({Key? key}) : super(key: key);

  @override
  State<CompanyEdit> createState() => _CompanyEditState();
}

class _CompanyEditState extends State<CompanyEdit> {
  final List<bool> _isOpen = List.filled(1, false);
  @override
  Widget build(BuildContext context) {
    var company = context.read<CompanyModel>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            BlocBuilder<CompaniesBloc, CompanyState>(
              builder: (context, state) =>
                  (state.action == CompanyAction.delete &&
                          state.status == CompanyStatus.loading)
                      ? const Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: LinearProgressIndicator(),
                        )
                      : Container(),
            ),
            CompanyWidget(company: company, showInfo: false),
            const SizedBox(height: 30),
            ExpansionPanelList(
              expandedHeaderPadding: const EdgeInsets.all(20),
              children: [
                ExpansionPanel(
                  isExpanded: _isOpen[0],
                  headerBuilder: (context, isExpanded) => ListTile(
                    leading: const Icon(Icons.edit_outlined),
                    title: Text(
                      AppLocalizations.of(context)!
                          .edit(AppLocalizations.of(context)!.company),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CompanyEditWidget(
                      company: company,
                    ),
                  ),
                ),
              ],
              expansionCallback: (index, isOpen) {
                setState(() {
                  _isOpen.fillRange(0, _isOpen.length, false);
                  _isOpen[index] = !isOpen;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
