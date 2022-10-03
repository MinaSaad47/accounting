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

class CompanyInfo extends StatefulWidget {
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
  State<CompanyInfo> createState() => _CompanyInfoState();
}

class _CompanyInfoState extends State<CompanyInfo> {
  late final company = context.read<CompanyModel>();
  final pageController = PageController(initialPage: 0);

  late final selectedColor = Theme.of(context).colorScheme.secondary;
  late final colorsList = [selectedColor, null, null, null];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEn = context.read<CachedRepository>().locale?.languageCode == 'en';
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
          title: Text(l10n.edit(company.id!.toString())),
          actions: [
            if (context.read<LoginCubit>().state.user!.isAdmin)
              IconButton(
                color: Colors.red.shade900,
                tooltip: l10n.delete,
                iconSize: 40,
                onPressed: () => Utils.adminDo(context, fn: () {
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
                if (!isEn) const Spacer(),
                Expanded(
                  child: MaterialButton(
                    color: colorsList[0],
                    onPressed: () {
                      setSelected(0);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(l10n.edit('')),
                        const Icon(Icons.edit_outlined),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    color: colorsList[1],
                    onPressed: () {
                      setSelected(1);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(l10n.funders),
                        const Icon(Icons.people_outline),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    color: colorsList[2],
                    onPressed: () {
                      setSelected(2);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(l10n.documents),
                        const Icon(Icons.document_scanner_outlined),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    color: colorsList[3],
                    onPressed: () {
                      setSelected(3);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FittedBox(
                          child: Text(l10n.expenses),
                        ),
                        const Icon(Icons.currency_exchange_outlined),
                      ],
                    ),
                  ),
                ),
                if (isEn) const Spacer(),
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
                  title: l10n.expenses,
                  textFields: [
                    DialogTextField(
                      hintText: l10n.expenses,
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            errorText: l10n.expect(
                              l10n.expenses,
                            ),
                          ),
                          FormBuilderValidators.numeric(
                            errorText: l10n.expect(
                              l10n.number,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DialogTextField(
                      autocorrect: true,
                      maxLines: 4,
                      hintText: l10n.description,
                      validator: FormBuilderValidators.required(
                        errorText: l10n.expect(l10n.description),
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
              label: l10n.add(l10n.expenses),
            ),
            SpeedDialChild(
              onTap: () => Utils.adminDo(context, password: false, fn: () {
                showTextInputDialog(
                  context: context,
                  title: l10n.incomes,
                  textFields: [
                    DialogTextField(
                      hintText: l10n.incomes,
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                            errorText: l10n.expect(
                              l10n.incomes,
                            ),
                          ),
                          FormBuilderValidators.numeric(
                            errorText: l10n.expect(
                              l10n.number,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DialogTextField(
                      autocorrect: true,
                      maxLines: 4,
                      hintText: l10n.description,
                      validator: FormBuilderValidators.required(
                        errorText: l10n.expect(l10n.description),
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
              label: l10n.add(l10n.incomes),
            ),
            SpeedDialChild(
              onTap: () => Utils.adminDo(context, password: false, fn: () {
                showTextInputDialog(
                  context: context,
                  textFields: [
                    DialogTextField(
                      hintText: l10n.funderName,
                      validator: FormBuilderValidators.required(
                        errorText: l10n.expect(l10n.funderName),
                      ),
                    )
                  ],
                ).then((inputs) {
                  var name = inputs?[0];
                  if (name != null) {
                    var funder = FunderModel(name: name);
                    var company = context.read<CompanyModel>();
                    context
                        .read<FunderBloc>()
                        .add(FunderCreateRequested(funder, company));
                  }
                });
              }),
              child: const Icon(Icons.person_outline),
              label: l10n.add(l10n.funders),
            ),
            SpeedDialChild(
              onTap: () => Utils.adminDo(context, password: false, fn: () {
                context
                    .read<DocumentBloc>()
                    .add(DocumentCreateRequested(company.id!, (perc) {}));
              }),
              child: const Icon(Icons.document_scanner_rounded),
              label: l10n.add(l10n.documents),
            ),
          ],
        ),
        floatingActionButtonLocation:
            context.read<CachedRepository>().locale?.languageCode == 'ar'
                ? FloatingActionButtonLocation.startDocked
                : FloatingActionButtonLocation.endDocked,
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
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

  void setSelected(int index) {
    setState(() {
      colorsList.fillRange(0, colorsList.length, null);
      colorsList[index] = selectedColor;
    });
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
