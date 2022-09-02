import 'package:accounting/common/common.dart';
import 'package:accounting/companies/bloc/companies_bloc.dart';
import 'package:accounting/login/cubit/login_cubit.dart';
import 'package:accounting/utils/utils.dart';
import 'package:accounting_api/accounting_api.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CompanyEditWidget extends StatefulWidget {
  final CompanyModel? company;
  const CompanyEditWidget({Key? key, this.company}) : super(key: key);

  @override
  State<CompanyEditWidget> createState() => _BuildCompanyEditFormState();
}

class _BuildCompanyEditFormState extends State<CompanyEditWidget> {
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
                      Utils.toast(
                        context,
                        message: state.error,
                        level: ToastLevel.error,
                      );
                    } else if (state is CompaniesSaveSuccess) {
                      Utils.toast(
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
          Utils.log.d(savedCompany.toString());
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
