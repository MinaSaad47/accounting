import 'package:accounting/common/common.dart';
import 'package:accounting/companies/bloc/expense_bloc.dart';
import 'package:accounting/companies/companies.dart';
import 'package:accounting/login/cubit/login_cubit.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CompaniesView extends StatelessWidget {
  const CompaniesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = context.read<LoginCubit>().state.user!;
    return DefaultTabController(
      length: user.isAdmin ? 2 : 1,
      child: Scaffold(
        appBar: AppBarWidget(
          title: AppLocalizations.of(context)!.companies,
          tabBar: TabBar(
            tabs: [
              Tab(
                child: Text(AppLocalizations.of(context)!
                    .search(AppLocalizations.of(context)!.company)),
              ),
              if (user.isAdmin)
                Tab(
                  child: Text(
                    AppLocalizations.of(context)!
                        .add(AppLocalizations.of(context)!.company),
                  ),
                ),
            ],
          ),
        ),
        drawer: const DrawerWidget(),
        body: TabBarView(
          children: [
            const _BuildSearchCompany(),
            if (user.isAdmin) const _BuildAddCompany(),
          ],
        ),
      ),
    );
  }
}

class _BuildSearchCompany extends StatelessWidget {
  const _BuildSearchCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SearchWidget(
            hintText: AppLocalizations.of(context)!
                .search(AppLocalizations.of(context)!.company),
            onChanged: (query) {
              if (query.isNotEmpty) {
                context
                    .read<CompaniesBloc>()
                    .add(CompaniesSearchRequested(query));
              }
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocConsumer<CompaniesBloc, CompaniesState>(
              listener: (context, state) {
                if (state is CompaniesGetInFailure) {
                  showToast(
                    context,
                    message: state.error,
                    level: ToastLevel.error,
                  );
                }
              },
              builder: (context, state) {
                if (state is CompaniesGetSuccess) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      var company = state.companies[index];
                      return _BuildCompanyItem(company: company);
                    },
                    separatorBuilder: (context, index) => Container(
                      margin: const EdgeInsets.all(10),
                      height: 2,
                    ),
                    itemCount: state.companies.length,
                  );
                } else if (state is CompaniesGetInProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class _BuildAddCompany extends StatelessWidget {
  const _BuildAddCompany({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _BuildCompanyEditForm();
  }
}

class _BuildCompanyInfo extends StatefulWidget {
  final CompanyModel company;
  const _BuildCompanyInfo({
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
          ],
          child: _BuildCompanyInfo(company: companyModel),
        ),
      );

  @override
  State<_BuildCompanyInfo> createState() => _BuildCompanyInfoState();
}

class _BuildCompanyInfoState extends State<_BuildCompanyInfo> {
  final List<bool> _isOpen = List.filled(2, false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)!.edit(widget.company.id!.toString())),
        actions: [
          if (context.read<LoginCubit>().state.user!.isAdmin)
            IconButton(
              color: Colors.red.shade900,
              tooltip: AppLocalizations.of(context)!.delete,
              iconSize: 40,
              onPressed: () {
                context
                    .read<CompaniesBloc>()
                    .add(CompaniesDeleteRequested(widget.company.id!));
              },
              icon: const Icon(
                Icons.delete_outline,
              ),
            )
        ],
      ),
      floatingActionButton: SpeedDial(
        overlayOpacity: 0,
        animatedIcon: AnimatedIcons.add_event,
        children: [
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
                  var moneyCapital = ExpenseModel(
                    value: num.parse(inputs![0]),
                    description: inputs[1],
                  );
                  context.read<ExpenseBloc>().add(
                        MoneyCapitalCreateRequested(
                          moneyCapital,
                          widget.company,
                        ),
                      );
                },
              );
            },
            child: const Icon(Icons.currency_exchange_outlined),
            label: AppLocalizations.of(context)!
                .add(AppLocalizations.of(context)!.expenses),
          ),
        ],
      ),
      floatingActionButtonLocation:
          context.read<CachedRepository>().locale?.languageCode == 'ar'
              ? FloatingActionButtonLocation.startFloat
              : FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
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
              _BuildCompanyItem(company: widget.company),
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
                      child: _BuildCompanyEditForm(
                        company: widget.company,
                      ),
                    ),
                  ),
                  ExpansionPanel(
                    isExpanded: _isOpen[1],
                    headerBuilder: (context, isExpanded) => ListTile(
                      leading: const Icon(Icons.currency_exchange_outlined),
                      title: Text(
                        AppLocalizations.of(context)!.expenses,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.attach_money_outlined),
                          const SizedBox(width: 5),
                          BlocBuilder<ExpenseBloc, ExpenseState>(
                            builder: (context, state) {
                              return Text(
                                state.list
                                    .map((e) => e.value)
                                    .fold(0.0, (p, c) => (p as double) + c)
                                    .toString(),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    body: _BuildExpanses(companyId: widget.company.id!),
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
      ),
    );
  }
}

class _BuildCompanyEditForm extends StatefulWidget {
  final CompanyModel? company;
  const _BuildCompanyEditForm({Key? key, this.company}) : super(key: key);

  @override
  State<_BuildCompanyEditForm> createState() => _BuildCompanyEditFormState();
}

class _BuildCompanyEditFormState extends State<_BuildCompanyEditForm> {
  var formKey = GlobalKey<FormBuilderState>();
  late var company = widget.company;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FormBuilder(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Wrap(
                children: [
                  if (company == null)
                    FormBuilderTextFieldWidget(
                      context,
                      name: AppLocalizations.of(context)!.funderName,
                    ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: AppLocalizations.of(context)!.commercialFeature,
                    value: company?.commercialFeature,
                  ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: AppLocalizations.of(context)!.legalEntity,
                    value: company?.legalEntity,
                  ),
                  FormBuilderDropdownWidget(
                    name: AppLocalizations.of(context)!.isWorking,
                    initialValue: company != null && company!.isWorking
                        ? AppLocalizations.of(context)!.working
                        : AppLocalizations.of(context)!.notWorking,
                    items: [
                      AppLocalizations.of(context)!.working,
                      AppLocalizations.of(context)!.notWorking,
                    ],
                  ),
                  if (company != null)
                    FormBuilderTextFieldWidget(
                      context,
                      name: AppLocalizations.of(context)!.fileNumber,
                      value: company?.fileNumber,
                      required: false,
                    ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: AppLocalizations.of(context)!.registerNumber,
                    value: company?.registerNumber,
                  ),
                  FormBuilderDateTimePickerWidget(
                    context,
                    name: AppLocalizations.of(context)!.startDate,
                    value: company?.startDate,
                  ),
                  if (company != null)
                    FormBuilderDateTimePickerWidget(
                      context,
                      name: AppLocalizations.of(context)!.stopDate,
                      value: company?.stopDate,
                      required: false,
                    ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: AppLocalizations.of(context)!.generalTaxMission,
                    value: company?.generalTaxMission,
                  ),
                  if (company != null)
                    FormBuilderTextFieldWidget(
                      context,
                      name: AppLocalizations.of(context)!.valueTaxMission,
                      value: company?.valueTaxMission,
                      required: false,
                    ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: AppLocalizations.of(context)!.activityNature,
                    value: company?.activityNature,
                  ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: AppLocalizations.of(context)!.activityLocation,
                    value: company?.activityLocation,
                  ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: AppLocalizations.of(context)!.accounts,
                    value: company?.accounts,
                  ),
                  if (company != null) ...[
                    FormBuilderDateTimePickerWidget(
                      context,
                      name: AppLocalizations.of(context)!.joiningDate,
                      value: company?.joiningDate,
                      required: false,
                    ),
                    FormBuilderTextFieldWidget(
                      context,
                      name: AppLocalizations.of(context)!.naturalId,
                      required: false,
                      value: company?.naturalId,
                    ),
                    FormBuilderTextFieldWidget(
                      context,
                      name: AppLocalizations.of(context)!.recordSide,
                      value: company?.recordSide?.toString(),
                      required: false,
                    ),
                  ],
                  FormBuilderTextFieldWidget(
                    context,
                    name: AppLocalizations.of(context)!.recordNumber,
                    value: company?.recordNumber.toString(),
                  ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: AppLocalizations.of(context)!.userName,
                    value: company?.userName,
                  ),
                  if (company != null) ...[
                    FormBuilderTextFieldWidget(
                      context,
                      name: AppLocalizations.of(context)!.passport,
                      value: company?.passport,
                      required: false,
                    ),
                    FormBuilderTextFieldWidget(
                      context,
                      name: AppLocalizations.of(context)!.verificationCode,
                      value: company?.verificationCode,
                      required: false,
                    ),
                  ],
                  FormBuilderTextFieldWidget(
                    context,
                    name: AppLocalizations.of(context)!.email,
                    value: company?.email,
                  ),
                ],
              ),
              if (company != null) ...[
                const SizedBox(height: 30),
                _BuildFunders(
                  funders: company?.funders,
                  onUpdate: (funders) {
                    company = company?.copyWith(funders: funders);
                  },
                ),
              ],
              if (context.read<LoginCubit>().state.user!.isAdmin)
                BlocConsumer<CompaniesBloc, CompaniesState>(
                  listener: (context, state) {
                    if (state is CompaniesSaveFailure) {
                      showToast(
                        context,
                        message: state.error,
                        level: ToastLevel.error,
                      );
                    } else if (state is CompaniesSaveSuccess) {
                      showToast(
                        context,
                        message: state.message,
                      );
                    }
                  },
                  builder: (context, state) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: state is CompaniesSaveInProgress
                        ? const CircularProgressIndicator()
                        : _BuildSaveCompanyButton(
                            formKey: formKey,
                            company: company,
                          ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildSaveCompanyButton extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final CompanyModel? company;
  const _BuildSaveCompanyButton({
    Key? key,
    required this.formKey,
    this.company,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        var formState = formKey.currentState!;
        if (formState.validate()) {
          formState.save();
          var savedCompany = CompanyModel(
            id: company?.id,
            funders: company?.funders ??
                [
                  FunderModel(
                    name: formState
                        .value[AppLocalizations.of(context)!.funderName],
                  )
                ],
            accounts: formState.value[AppLocalizations.of(context)!.accounts],
            isWorking:
                formState.value[AppLocalizations.of(context)!.isWorking] ==
                    AppLocalizations.of(context)!.working,
            joiningDate:
                formState.value[AppLocalizations.of(context)!.joiningDate],
            stopDate: formState.value[AppLocalizations.of(context)!.stopDate],
            startDate: formState.value[AppLocalizations.of(context)!.startDate],
            fileNumber:
                formState.value[AppLocalizations.of(context)!.fileNumber],
            email: formState.value[AppLocalizations.of(context)!.email],
            passport: formState.value[AppLocalizations.of(context)!.passport],
            userName: formState.value[AppLocalizations.of(context)!.userName],
            recordNumber:
                formState.value[AppLocalizations.of(context)!.recordNumber],
            recordSide:
                formState.value[AppLocalizations.of(context)!.recordSide],
            valueTaxMission:
                formState.value[AppLocalizations.of(context)!.valueTaxMission],
            naturalId: formState.value[AppLocalizations.of(context)!.naturalId],
            activityLocation:
                formState.value[AppLocalizations.of(context)!.activityLocation],
            activityNature:
                formState.value[AppLocalizations.of(context)!.activityNature],
            generalTaxMission: formState
                .value[AppLocalizations.of(context)!.generalTaxMission],
            registerNumber:
                formState.value[AppLocalizations.of(context)!.registerNumber],
            legalEntity:
                formState.value[AppLocalizations.of(context)!.legalEntity],
            commercialFeature: formState
                .value[AppLocalizations.of(context)!.commercialFeature],
            verificationCode:
                formState.value[AppLocalizations.of(context)!.verificationCode],
          );
          log.d(savedCompany.toString());
          if (company == null) {
            context
                .read<CompaniesBloc>()
                .add(CompaniesCreateRequested(savedCompany));
          } else {
            context
                .read<CompaniesBloc>()
                .add(CompaniesEditRequested(savedCompany));
          }
        }
      },
      child: Text(
        AppLocalizations.of(context)!
            .save(AppLocalizations.of(context)!.company),
      ),
    );
  }
}

class _BuildExpanses extends StatefulWidget {
  final int companyId;
  const _BuildExpanses({
    Key? key,
    required this.companyId,
  }) : super(key: key);

  @override
  State<_BuildExpanses> createState() => _BuildExpansesState();
}

class _BuildExpansesState extends State<_BuildExpanses> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpenseBloc, ExpenseState>(
      listener: (context, state) {
        if (state.status == ExpenseStatus.failure) {
          showToast(context, message: state.message, level: ToastLevel.error);
        } else if (state.action != ExpenseAction.get &&
            state.status == ExpenseStatus.success) {
          var user = context.read<LoginCubit>().state.user!;
          context.read<ExpenseBloc>().add(ExpenseGetRequested(
                companyId: widget.companyId,
                empolyeeId: !user.isAdmin ? user.id : null,
              ));
          context.read<LoginCubit>().getCurrentUser();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              if (state.status == ExpenseStatus.loading)
                const LinearProgressIndicator(),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => ExpenseWidget(
                  expense: state.list[index],
                  onDelete: () {
                    context.read<ExpenseBloc>().add(
                          ExpenseDeleteRequested(
                            state.list[index].id!,
                          ),
                        );
                  },
                ),
                separatorBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(20),
                  height: 2,
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                ),
                itemCount: state.list.length,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BuildFunders extends StatefulWidget {
  final List<FunderModel>? funders;
  final Function(List<FunderModel>) onUpdate;
  const _BuildFunders({
    Key? key,
    this.funders,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<_BuildFunders> createState() => _BuildFundersState();
}

class _BuildFundersState extends State<_BuildFunders> {
  late var funders = widget.funders;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.funders,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    var inputs = await showTextInputDialog(
                      context: context,
                      textFields: [
                        DialogTextField(
                          hintText: AppLocalizations.of(context)!.funderName,
                          validator: FormBuilderValidators.required(
                            errorText: AppLocalizations.of(context)!.expect(
                              AppLocalizations.of(context)!.funderName,
                            ),
                          ),
                        ),
                      ],
                    );
                    var name = inputs![0];
                    setState(() {
                      funders = [...?funders, FunderModel(name: name)];
                    });
                    widget.onUpdate(funders!);
                  },
                  icon: const Icon(Icons.add_outlined),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              height: 2,
            ),
          ),
          ...?funders
              ?.map((f) => ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(f.name),
                  ))
              .toList(),
        ],
      ),
    );
  }
}

class _BuildCompanyItem extends StatelessWidget {
  final CompanyModel company;
  const _BuildCompanyItem({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListItemWidget(
      title: company.id.toString(),
      onPressed: () {
        Navigator.of(context).push(_BuildCompanyInfo.route(context, company));
      },
      labels: [
        TextLabelWidget(
          icon: Icons.featured_play_list_outlined,
          title: AppLocalizations.of(context)!.registerNumber,
          content: company.registerNumber,
        ),
        TextLabelWidget(
          icon: Icons.person,
          title: AppLocalizations.of(context)!.funderName,
          content: company.funders[0].name,
        ),
        TextLabelWidget(
          icon: Icons.featured_play_list_outlined,
          title: AppLocalizations.of(context)!.commercialFeature,
          content: company.commercialFeature,
        )
      ],
    );
  }
}
