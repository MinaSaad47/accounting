import 'package:accounting/common/common.dart';
import 'package:accounting/companies/bloc/document_bloc.dart';
import 'package:accounting/companies/bloc/expense_bloc.dart';
import 'package:accounting/companies/bloc/funder_bloc.dart';
import 'package:accounting/companies/bloc/income_bloc.dart';
import 'package:accounting/companies/companies.dart';
import 'package:accounting/companies/view/company_edit.dart';
import 'package:accounting/companies/view/funders_list.dart';
import 'package:accounting/login/cubit/login_cubit.dart';
import 'package:accounting/utils/utils.dart';
import 'package:accounting_api/accounting_api.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CompanyInfo extends StatelessWidget {
  const CompanyInfo({
    Key? key,
  }) : super(key: key);

  static route(BuildContext context, CompanyModel company) {
    return MaterialPageRoute(builder: (_) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<CompaniesBloc>.value(
            value: context.read<CompaniesBloc>(),
          ),
          BlocProvider(
            create: (context) {
              return ExpenseBloc(
                context.read<AccountingRepository>(),
              )..add(ExpenseGetRequested(
                  companyId: company.id,
                ));
            },
          ),
          BlocProvider(
            create: (context) {
              return IncomeBloc(
                context.read<AccountingRepository>(),
              )..add(IncomeGetRequested(companyId: company.id));
            },
          ),
          BlocProvider(
            create: (context) {
              return DocumentBloc(
                context.read<AccountingRepository>(),
              )..add(DocumentGetRequested(company.id!));
            },
          ),
          BlocProvider(
            create: (context) {
              return FunderBloc(
                context.read<AccountingRepository>(),
              )..add(FunderGetRequested(company.id!));
            },
          ),
        ],
        child: RepositoryProvider.value(
          value: company,
          child: const CompanyInfo(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var company = context.read<CompanyModel>();
    var pageController = PageController(initialPage: 0);
    return MultiBlocListener(
      listeners: [
        BlocListener<FunderBloc, FunderState>(
          listener: (context, state) {
            switch (state.status) {
              case FunderStatus.failure:
                Utils.toast(
                  context,
                  message: state.message,
                  level: ToastLevel.error,
                );
                break;
              case FunderStatus.success:
                switch (state.action) {
                  case FunderAction.get:
                    break;
                  default:
                    context
                        .read<FunderBloc>()
                        .add(FunderGetRequested(company.id!));
                    Utils.toast(
                      context,
                      message: state.message,
                    );
                }
                break;
              default:
            }
          },
        ),
        BlocListener<DocumentBloc, DocumentState>(
          listener: (context, state) {
            switch (state.status) {
              case DocumentStatus.failure:
                Utils.toast(
                  context,
                  message: state.message,
                  level: ToastLevel.error,
                );
                break;
              case DocumentStatus.success:
                switch (state.action) {
                  case DocumentAction.get:
                    break;
                  default:
                    context
                        .read<DocumentBloc>()
                        .add(DocumentGetRequested(company.id!));
                    Utils.toast(
                      context,
                      message: state.message,
                    );
                }
                break;
              default:
            }
          },
        ),
        BlocListener<IncomeBloc, IncomeState>(
          listener: (context, state) {
            switch (state.status) {
              case IncomeStatus.failure:
                Utils.toast(
                  context,
                  message: state.message,
                  level: ToastLevel.error,
                );
                break;
              case IncomeStatus.success:
                switch (state.action) {
                  case IncomeAction.get:
                    break;
                  default:
                    context
                        .read<IncomeBloc>()
                        .add(IncomeGetRequested(companyId: company.id!));
                    Utils.toast(
                      context,
                      message: state.message,
                    );
                }
                break;
              default:
            }
          },
        ),
        BlocListener<ExpenseBloc, ExpenseState>(
          listener: (context, state) {
            switch (state.status) {
              case ExpenseStatus.failure:
                Utils.toast(
                  context,
                  message: state.message,
                  level: ToastLevel.error,
                );
                break;
              case ExpenseStatus.success:
                switch (state.action) {
                  case ExpenseAction.get:
                    break;
                  default:
                    context
                        .read<ExpenseBloc>()
                        .add(ExpenseGetRequested(companyId: company.id!));
                    Utils.toast(
                      context,
                      message: state.message,
                    );
                }
                break;
              default:
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(AppLocalizations.of(context)!.edit(company.id!.toString())),
          actions: [
            if (context.read<LoginCubit>().state.user!.isAdmin)
              IconButton(
                color: Colors.red.shade900,
                tooltip: AppLocalizations.of(context)!.delete,
                iconSize: 40,
                onPressed: () => Utils.adminDo(context, () {
                  context
                      .read<CompaniesBloc>()
                      .add(CompanyDeleteRequested(company.id!));
                }),
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
                const Spacer(),
                Expanded(
                  child: MaterialButton(
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
                ),
                Expanded(
                  child: MaterialButton(
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
                ),
                Expanded(
                  child: MaterialButton(
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
                        Text(AppLocalizations.of(context)!.documents),
                        const Icon(Icons.document_scanner_outlined),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      pageController.animateToPage(
                        3,
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
              onTap: () => Utils.adminDo(context, () {
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
              }),
              child: const Icon(Icons.move_to_inbox_outlined),
              label: AppLocalizations.of(context)!
                  .add(AppLocalizations.of(context)!.incomes),
            ),
            SpeedDialChild(
              onTap: () => Utils.adminDo(context, () {
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
                ).then((inputs) {
                  var name = inputs?[0];
                  if (name != null) {
                    var funder = FunderModel(name: name, companyId: -1);
                    var company = context.read<CompanyModel>();
                    context
                        .read<FunderBloc>()
                        .add(FunderCreateRequested(funder, company));
                  }
                });
              }),
              child: const Icon(Icons.person_outline),
              label: AppLocalizations.of(context)!
                  .add(AppLocalizations.of(context)!.funders),
            ),
            SpeedDialChild(
              onTap: () => Utils.adminDo(context, () {
                context
                    .read<DocumentBloc>()
                    .add(DocumentCreateRequested(company.id!, (perc) {}));
              }),
              child: const Icon(Icons.document_scanner_rounded),
              label: AppLocalizations.of(context)!
                  .add(AppLocalizations.of(context)!.documents),
            ),
          ],
        ),
        floatingActionButtonLocation:
            context.read<CachedRepository>().locale?.languageCode == 'ar'
                ? FloatingActionButtonLocation.startDocked
                : FloatingActionButtonLocation.endDocked,
        body: PageView(
          controller: pageController,
          children: const [
            CompanyEdit(),
            FundersList(),
            DocuementsList(),
            IncomesAndExpensesList(),
          ],
        ),
      ),
    );
  }
}
