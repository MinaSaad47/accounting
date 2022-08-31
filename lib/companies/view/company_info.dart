import 'package:accounting/common/common.dart';
import 'package:accounting/companies/bloc/expense_bloc.dart';
import 'package:accounting/companies/bloc/income_bloc.dart';
import 'package:accounting/companies/companies.dart';
import 'package:accounting/companies/view/company_edit.dart';
import 'package:accounting/login/cubit/login_cubit.dart';
import 'package:accounting_api/accounting_api.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CompanyInfo extends StatelessWidget {
  final CompanyModel company;
  const CompanyInfo({
    Key? key,
    required this.company,
  }) : super(key: key);

  static route(BuildContext context, CompanyModel companyModel) =>
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider<CompaniesBloc>.value(
              value: context.read<CompaniesBloc>(),
            ),
            BlocProvider(
              create: (context) {
                var user = context.read<LoginCubit>().state.user!;
                return ExpenseBloc(
                  context.read<AccountingRepository>(),
                )..add(ExpenseGetRequested(
                    companyId: companyModel.id,
                    empolyeeId: !user.isAdmin ? user.id : null,
                  ));
              },
            ),
            BlocProvider(
              create: (context) {
                return IncomeBloc(
                  context.read<AccountingRepository>(),
                )..add(IncomeGetRequested(
                    companyId: companyModel.id,
                  ));
              },
            ),
          ],
          child: CompanyInfo(company: companyModel),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var pageController = PageController(initialPage: 0);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.edit(company.id!.toString())),
        actions: [
          if (context.read<LoginCubit>().state.user!.isAdmin)
            IconButton(
              color: Colors.red.shade900,
              tooltip: AppLocalizations.of(context)!.delete,
              iconSize: 40,
              onPressed: () {
                context
                    .read<CompaniesBloc>()
                    .add(CompaniesDeleteRequested(company.id!));
              },
              icon: const Icon(
                Icons.delete_outline,
              ),
            )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppLocalizations.of(context)!.edit('')),
                    const Icon(Icons.edit_outlined),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppLocalizations.of(context)!.funders),
                    const Icon(Icons.people_outline),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        '${AppLocalizations.of(context)!.incomes} / ${AppLocalizations.of(context)!.expenses}'),
                    const Icon(Icons.currency_exchange_outlined),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        overlayOpacity: 0,
        animatedIcon: AnimatedIcons.add_event,
        children: [
          SpeedDialChild(
            onTap: () {
              showTextInputDialog(
                context: context,
                title: AppLocalizations.of(context)!.expenses,
                textFields: [
                  DialogTextField(
                    hintText: AppLocalizations.of(context)!.expenses,
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(
                          errorText: AppLocalizations.of(context)!.expect(
                            AppLocalizations.of(context)!.expenses,
                          ),
                        ),
                        FormBuilderValidators.numeric(
                          errorText: AppLocalizations.of(context)!.expect(
                            AppLocalizations.of(context)!.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DialogTextField(
                    autocorrect: true,
                    maxLines: 4,
                    hintText: AppLocalizations.of(context)!.description,
                    validator: FormBuilderValidators.required(
                      errorText: AppLocalizations.of(context)!
                          .expect(AppLocalizations.of(context)!.description),
                    ),
                  )
                ],
              ).then(
                (inputs) {
                  var expense = ExpenseModel(
                    value: num.parse(inputs![0]),
                    description: inputs[1],
                  );
                  context.read<ExpenseBloc>().add(
                        ExpenseCreateRequested(
                          expense,
                          company,
                        ),
                      );
                },
              );
            },
            child: const Icon(Icons.outbox_outlined),
            label: AppLocalizations.of(context)!
                .add(AppLocalizations.of(context)!.expenses),
          ),
          SpeedDialChild(
            onTap: () {
              showTextInputDialog(
                context: context,
                title: AppLocalizations.of(context)!.incomes,
                textFields: [
                  DialogTextField(
                    hintText: AppLocalizations.of(context)!.incomes,
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(
                          errorText: AppLocalizations.of(context)!.expect(
                            AppLocalizations.of(context)!.incomes,
                          ),
                        ),
                        FormBuilderValidators.numeric(
                          errorText: AppLocalizations.of(context)!.expect(
                            AppLocalizations.of(context)!.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DialogTextField(
                    autocorrect: true,
                    maxLines: 4,
                    hintText: AppLocalizations.of(context)!.description,
                    validator: FormBuilderValidators.required(
                      errorText: AppLocalizations.of(context)!
                          .expect(AppLocalizations.of(context)!.description),
                    ),
                  )
                ],
              ).then(
                (inputs) {
                  var income = IncomeModel(
                    value: num.parse(inputs![0]),
                    description: inputs[1],
                  );
                  context.read<IncomeBloc>().add(
                        IncomeCreateRequested(
                          income,
                          company,
                        ),
                      );
                },
              );
            },
            child: const Icon(Icons.move_to_inbox_outlined),
            label: AppLocalizations.of(context)!
                .add(AppLocalizations.of(context)!.incomes),
          ),
          SpeedDialChild(
            onTap: () {
              showTextInputDialog(
                context: context,
                textFields: [
                  DialogTextField(
                    hintText: AppLocalizations.of(context)!.funderName,
                    validator: FormBuilderValidators.required(
                      errorText: AppLocalizations.of(context)!
                          .expect(AppLocalizations.of(context)!.funderName),
                    ),
                  )
                ],
              );
            },
            child: const Icon(Icons.person_outline),
            label: AppLocalizations.of(context)!
                .add(AppLocalizations.of(context)!.funders),
          ),
        ],
      ),
      floatingActionButtonLocation:
          context.read<CachedRepository>().locale?.languageCode == 'ar'
              ? FloatingActionButtonLocation.startDocked
              : FloatingActionButtonLocation.endDocked,
      body: PageView(
        controller: pageController,
        children: [
          CompanyEdit(company: company),
          Container(),
          IncomesAndExpensesList(companyId: company.id!),
        ],
      ),
    );
  }
}
