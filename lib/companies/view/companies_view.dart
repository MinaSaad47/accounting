import 'package:accounting/common/common.dart';
import 'package:accounting/companies/bloc/companies_bloc.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CompaniesView extends StatelessWidget {
  const CompaniesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBarWidget(
          title: AppLocalizations.of(context)!.companies,
          tabBar: TabBar(
            tabs: [
              Tab(
                child: Text(AppLocalizations.of(context)!
                    .search(AppLocalizations.of(context)!.company)),
              ),
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
        body: const TabBarView(
          children: [
            _BuildSearchCompany(),
            _BuildAddCompany(),
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
                      return ListItemWidget(
                        title: company.id.toString(),
                        onPressed: () {
                          Navigator.of(context)
                              .push(_BuildEditCompany.route(context, company));
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
                            title:
                                AppLocalizations.of(context)!.commercialFeature,
                            content: company.commercialFeature,
                          )
                        ],
                      );
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
    return const _BuildCompanyForm();
  }
}

class _BuildEditCompany extends StatelessWidget {
  final CompanyModel company;
  const _BuildEditCompany({
    Key? key,
    required this.company,
  }) : super(key: key);

  static route(BuildContext context, CompanyModel companyModel) =>
      MaterialPageRoute(
        builder: (_) => BlocProvider<CompaniesBloc>.value(
          value: context.read<CompaniesBloc>(),
          child: _BuildEditCompany(company: companyModel),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.edit(company.id!.toString())),
      ),
      body: _BuildCompanyForm(company: company),
    );
  }
}

class _BuildCompanyForm extends StatefulWidget {
  final CompanyModel? company;
  const _BuildCompanyForm({Key? key, this.company}) : super(key: key);

  @override
  State<_BuildCompanyForm> createState() => _BuildCompanyFormState();
}

class _BuildCompanyFormState extends State<_BuildCompanyForm> {
  var formKey = GlobalKey<FormBuilderState>();
  late var company = widget.company;
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Wrap(
                      children: [
                        if (company == null)
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.funderName,
                          ),
                        _BuildFormBuilderTextField(
                          context,
                          name: AppLocalizations.of(context)!.commercialFeature,
                          value: company?.commercialFeature,
                        ),
                        _BuildFormBuilderTextField(
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
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.fileNumber,
                            value: company?.fileNumber,
                            required: false,
                          ),
                        _BuildFormBuilderTextField(
                          context,
                          name: AppLocalizations.of(context)!.registerNumber,
                          value: company?.registerNumber,
                        ),
                        _BuildFormBuilderDateTimePicker(
                          context,
                          name: AppLocalizations.of(context)!.startDate,
                          value: company?.startDate,
                        ),
                        if (company != null)
                          _BuildFormBuilderDateTimePicker(
                            context,
                            name: AppLocalizations.of(context)!.stopDate,
                            value: company?.stopDate,
                            required: false,
                          ),
                        _BuildFormBuilderTextField(
                          context,
                          name: AppLocalizations.of(context)!.generalTaxMission,
                          value: company?.generalTaxMission,
                        ),
                        if (company != null)
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.valueTaxMission,
                            value: company?.valueTaxMission,
                            required: false,
                          ),
                        _BuildFormBuilderTextField(
                          context,
                          name: AppLocalizations.of(context)!.activityNature,
                          value: company?.activityNature,
                        ),
                        _BuildFormBuilderTextField(
                          context,
                          name: AppLocalizations.of(context)!.activityLocation,
                          value: company?.activityLocation,
                        ),
                        _BuildFormBuilderTextField(
                          context,
                          name: AppLocalizations.of(context)!.accounts,
                          value: company?.accounts,
                        ),
                        if (company != null) ...[
                          _BuildFormBuilderDateTimePicker(
                            context,
                            name: AppLocalizations.of(context)!.joiningDate,
                            value: company?.joiningDate,
                            required: false,
                          ),
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.naturalId,
                            required: false,
                            value: company?.naturalId,
                          ),
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.recordSide,
                            value: company?.recordSide?.toString(),
                            required: false,
                          ),
                        ],
                        _BuildFormBuilderTextField(
                          context,
                          name: AppLocalizations.of(context)!.recordNumber,
                          value: company?.recordNumber.toString(),
                        ),
                        _BuildFormBuilderTextField(
                          context,
                          name: AppLocalizations.of(context)!.userName,
                          value: company?.userName,
                        ),
                        if (company != null) ...[
                          _BuildFormBuilderTextField(
                            context,
                            name: AppLocalizations.of(context)!.passport,
                            value: company?.passport,
                            required: false,
                          ),
                          _BuildFormBuilderTextField(
                            context,
                            name:
                                AppLocalizations.of(context)!.verificationCode,
                            value: company?.verificationCode,
                            required: false,
                          ),
                        ],
                        _BuildFormBuilderTextField(
                          context,
                          name: AppLocalizations.of(context)!.email,
                          value: company?.email,
                        ),
                      ],
                    ),
                    if (company != null) ...[
                      const SizedBox(height: 30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: _BuildFunders(
                              funders: company?.funders,
                              onUpdate: (funders) {
                                company = company?.copyWith(funders: funders);
                              },
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            flex: 1,
                            child: _BuildMoneyCapitals(
                              moneyCapitals: company?.moneyCapitals,
                              onUpdate: (moneyCapitals) {
                                company = company?.copyWith(
                                  moneyCapitals: moneyCapitals,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            BlocConsumer<CompaniesBloc, CompaniesState>(
              listener: (context, state) {
                if (state is CompaniesSaveInFailure) {
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
                    : ElevatedButton(
                        onPressed: () {
                          var formState = formKey.currentState!;
                          if (formState.validate()) {
                            formState.save();
                            var savedCompany = CompanyModel(
                              id: company?.id,
                              funders: company?.funders ??
                                  [
                                    FunderModel(
                                      name: formState.value[
                                          AppLocalizations.of(context)!
                                              .funderName],
                                    )
                                  ],
                              accounts: formState.value[
                                  AppLocalizations.of(context)!.accounts],
                              isWorking: formState.value[
                                      AppLocalizations.of(context)!
                                          .isWorking] ==
                                  AppLocalizations.of(context)!.working,
                              joiningDate: formState.value[
                                  AppLocalizations.of(context)!.joiningDate],
                              stopDate: formState.value[
                                  AppLocalizations.of(context)!.stopDate],
                              startDate: formState.value[
                                  AppLocalizations.of(context)!.startDate],
                              fileNumber: formState.value[
                                  AppLocalizations.of(context)!.fileNumber],
                              email: formState
                                  .value[AppLocalizations.of(context)!.email],
                              passport: formState.value[
                                  AppLocalizations.of(context)!.passport],
                              userName: formState.value[
                                  AppLocalizations.of(context)!.userName],
                              recordNumber: formState.value[
                                  AppLocalizations.of(context)!.recordNumber],
                              recordSide: formState.value[
                                  AppLocalizations.of(context)!.recordSide],
                              valueTaxMission: formState.value[
                                  AppLocalizations.of(context)!
                                      .valueTaxMission],
                              naturalId: formState.value[
                                  AppLocalizations.of(context)!.naturalId],
                              activityLocation: formState.value[
                                  AppLocalizations.of(context)!
                                      .activityLocation],
                              activityNature: formState.value[
                                  AppLocalizations.of(context)!.activityNature],
                              generalTaxMission: formState.value[
                                  AppLocalizations.of(context)!
                                      .generalTaxMission],
                              registerNumber: formState.value[
                                  AppLocalizations.of(context)!.registerNumber],
                              legalEntity: formState.value[
                                  AppLocalizations.of(context)!.legalEntity],
                              commercialFeature: formState.value[
                                  AppLocalizations.of(context)!
                                      .commercialFeature],
                              verificationCode: formState.value[
                                  AppLocalizations.of(context)!
                                      .verificationCode],
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
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BuildMoneyCapitals extends StatefulWidget {
  final List<MoneyCapitalModel>? moneyCapitals;
  final Function(List<MoneyCapitalModel>) onUpdate;
  const _BuildMoneyCapitals({
    Key? key,
    this.moneyCapitals,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<_BuildMoneyCapitals> createState() => _BuildMoneyCapitalsState();
}

class _BuildMoneyCapitalsState extends State<_BuildMoneyCapitals> {
  late var moneyCapitals = widget.moneyCapitals;
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
                  AppLocalizations.of(context)!.moneyCapital,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    var inputs = await showTextInputDialog(
                      context: context,
                      textFields: [
                        DialogTextField(
                          hintText: AppLocalizations.of(context)!.moneyCapital,
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.numeric(
                                errorText: AppLocalizations.of(context)!.expect(
                                  AppLocalizations.of(context)!.number,
                                ),
                              ),
                              FormBuilderValidators.required(
                                errorText: AppLocalizations.of(context)!.expect(
                                  AppLocalizations.of(context)!.moneyCapital,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                    var value = inputs![0];
                    setState(() {
                      moneyCapitals = [
                        ...?moneyCapitals,
                        MoneyCapitalModel(
                          value: num.parse(value),
                          time: DateTime.now(),
                        )
                      ];
                    });
                    widget.onUpdate(moneyCapitals!);
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
          ...?moneyCapitals
              ?.map((m) => ListTile(
                    leading: Icon(
                      Icons.attach_money_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(m.value.toString()),
                    trailing: Text(m.time.toString()),
                  ))
              .toList(),
        ],
      ),
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

class _BuildFormBuilderDateTimePicker extends StatelessWidget {
  final String name;
  final DateTime? value;
  final bool required;
  const _BuildFormBuilderDateTimePicker(
    BuildContext context, {
    Key? key,
    required this.name,
    this.value,
    this.required = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = double.infinity;
        if (constraints.maxWidth > 600) {
          width = constraints.maxWidth / 2;
        }
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderDateTimePicker(
              decoration: InputDecoration(
                labelText: name,
              ),
              style: Theme.of(context).textTheme.headline6,
              initialValue: value,
              name: name,
              validator: (date) {
                if (!required || date != null) return null;
                return AppLocalizations.of(context)!.expect(name);
              },
            ),
          ),
        );
      },
    );
  }
}

class _BuildFormBuilderTextField extends StatelessWidget {
  final String name;
  final String? value;
  final bool required;
  final String? Function(String?)? validator;
  _BuildFormBuilderTextField(
    BuildContext context, {
    Key? key,
    required this.name,
    this.value,
    this.required = true,
    String? Function(String?)? validator,
  })  : validator = validator ??
            FormBuilderValidators.required(
              errorText: AppLocalizations.of(context)!.expect(name),
            ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = double.infinity;
        if (constraints.maxWidth > 600) {
          width = constraints.maxWidth / 2;
        }
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: width,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderTextField(
              initialValue: value,
              name: name,
              decoration: InputDecoration(
                labelText: name,
              ),
              style: Theme.of(context).textTheme.headline6,
              validator: (text) {
                if (!required) return null;
                return validator != null ? validator!(text) : null;
              },
            ),
          ),
        );
      },
    );
  }
}
