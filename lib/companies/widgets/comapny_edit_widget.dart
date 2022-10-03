import 'package:accounting/common/common.dart';
import 'package:accounting/companies/bloc/company_bloc.dart';
import 'package:accounting/login/cubit/login_cubit.dart';
import 'package:accounting/utils/utils.dart';
import 'package:accounting_api/accounting_api.dart';
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
    final l10n = AppLocalizations.of(context)!;
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
                  FormBuilderTextFieldWidget(
                    context,
                    name: l10n.owner,
                    value: company?.owner,
                    required: true,
                  ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: l10n.commercialFeature,
                    value: company?.commercialFeature,
                    required: true,
                  ),
                  FormBuilderDropdownWidget(
                    name: l10n.isWorking,
                    initialValue: company != null && company!.isWorking
                        ? l10n.working
                        : l10n.notWorking,
                    items: [
                      l10n.working,
                      l10n.notWorking,
                    ],
                  ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: l10n.legalEntity,
                    value: company?.legalEntity,
                  ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: l10n.fileNumber,
                    value: company?.fileNumber,
                    validator: FormBuilderValidators.numeric(
                      errorText: l10n.expect(l10n.number),
                    ),
                  ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: l10n.registerNumber,
                    value: company?.registerNumber,
                    validator: FormBuilderValidators.numeric(
                      errorText: l10n.expect(l10n.number),
                    ),
                  ),
                  FormBuilderDateTimePickerWidget(
                    context,
                    name: l10n.startDate,
                    value: company?.startDate,
                  ),
                  FormBuilderDateTimePickerWidget(
                    context,
                    name: l10n.stopDate,
                    value: company?.stopDate,
                  ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: l10n.generalTaxMission,
                    value: company?.generalTaxMission,
                  ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: l10n.valueTaxMission,
                    value: company?.valueTaxMission,
                  ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: l10n.activityNature,
                    value: company?.activityNature,
                  ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: l10n.activityLocation,
                    value: company?.activityLocation,
                  ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: l10n.recordNumber,
                    value: company?.recordNumber,
                    validator: FormBuilderValidators.numeric(
                      errorText: l10n.expect(l10n.number),
                    ),
                  ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: l10n.username,
                    value: company?.username,
                  ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: l10n.password,
                    value: company?.password,
                  ),
                  FormBuilderTextFieldWidget(
                    context,
                    name: l10n.email,
                    value: company?.email,
                    validator: FormBuilderValidators.email(
                      errorText: l10n.notCorrect(l10n.email),
                    ),
                  ),
                ],
              ),
              if (context.read<LoginCubit>().state.user!.isAdmin)
                BlocBuilder<CompaniesBloc, CompanyState>(
                  builder: (context, state) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (state.action == CompanyAction.save &&
                            state.status == CompanyStatus.loading)
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
    final l10n = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: () =>
          Utils.adminDo(context, password: company != null, fn: () {
        var formState = formKey.currentState!;
        if (formState.validate()) {
          formState.save();
          _save(context, company?.id, formState.value);
        }
      }),
      child: Text(
        l10n.save(l10n.company),
      ),
    );
  }

  void _save(BuildContext context, String? id, Map<String, dynamic> value) {
    final l10n = AppLocalizations.of(context)!;
    var savedCompany = CompanyModel(
      id: id,
      isWorking: value[l10n.isWorking] == l10n.working,
      stopDate: value[l10n.stopDate],
      startDate: value[l10n.startDate],
      fileNumber: value[l10n.fileNumber] != '' ? value[l10n.fileNumber] : null,
      email: value[l10n.email]?.trim(),
      password: value[l10n.password],
      username: value[l10n.username]?.trim(),
      recordNumber:
          value[l10n.recordNumber] != '' ? value[l10n.recordNumber] : null,
      valueTaxMission: value[l10n.valueTaxMission]?.trim(),
      activityLocation: value[l10n.activityLocation]?.trim(),
      activityNature: value[l10n.activityNature]?.trim(),
      generalTaxMission: value[l10n.generalTaxMission]?.trim(),
      registerNumber:
          value[l10n.registerNumber] != '' ? value[l10n.registerNumber] : null,
      legalEntity: value[l10n.legalEntity]?.trim(),
      commercialFeature: value[l10n.commercialFeature].trim(),
      owner: value[l10n.owner].trim(),
    );
    Utils.log.d(savedCompany.toString());
    if (company == null) {
      context.read<CompaniesBloc>().add(CompanyCreateRequested(savedCompany));
    } else {
      context.read<CompaniesBloc>().add(CompanyEditRequested(savedCompany));
    }
  }
}
