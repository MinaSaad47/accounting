import 'package:accounting/common/common.dart';
import 'package:accounting/companies/companies.dart';
import 'package:accounting/companies/widgets/company_widget.dart';
import 'package:accounting_api/accounting_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyEdit extends StatefulWidget {
  final CompanyModel company;
  const CompanyEdit({Key? key, required this.company}) : super(key: key);

  @override
  State<CompanyEdit> createState() => _CompanyEditState();
}

class _CompanyEditState extends State<CompanyEdit> {
  final List<bool> _isOpen = List.filled(1, false);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            BlocConsumer<CompaniesBloc, CompaniesState>(
              builder: (context, state) => state is CompaniesDeleteInProgress
                  ? const Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: LinearProgressIndicator(),
                    )
                  : Container(),
              listener: (context, state) {
                if (state is CompaniesDeleteSuccess) {
                  showToast(context, message: state.message);
                  Navigator.of(context).pop();
                } else if (state is CompaniesDeleteFailure) {
                  showToast(
                    context,
                    message: state.error,
                    level: ToastLevel.error,
                  );
                }
              },
            ),
            CompanyWidget(company: widget.company),
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
                      company: widget.company,
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
