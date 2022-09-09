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
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: AppLocalizations.of(context)!.expect(
                            AppLocalizations.of(context)!.registerNumber),
                      ),
                      FormBuilderValidators.numeric(
                        errorText: AppLocalizations.of(context)!.expect(
                          AppLocalizations.of(context)!.number,
                        ),
                      ),
                    ]),
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
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: AppLocalizations.of(context)!
                            .expect(AppLocalizations.of(context)!.recordNumber),
                      ),
                      FormBuilderValidators.numeric(
                        errorText: AppLocalizations.of(context)!.expect(
                          AppLocalizations.of(context)!.number,
                        ),
                      ),
                    ]),
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
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: AppLocalizations.of(context)!.expect(
                          AppLocalizations.of(context)!.email,
                        ),
                      ),
                      FormBuilderValidators.email(
                        errorText: AppLocalizations.of(context)!.notCorrect(
                          AppLocalizations.of(context)!.email,
                        ),
                      ),
                    ]),
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
    return ElevatedButton(
      onPressed: () =>
          Utils.adminDo(context, password: company != null, fn: () {
        var formState = formKey.currentState!;
        if (formState.validate()) {
          formState.save();
          var savedCompany = CompanyModel(
            id: company?.id,
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
                .add(CompanyCreateRequested(savedCompany));
          } else {
            context
                .read<CompaniesBloc>()
                .add(CompanyEditRequested(savedCompany));
          }
        }
      }),
      child: Text(
        AppLocalizations.of(context)!
            .save(AppLocalizations.of(context)!.company),
      ),
    );
  }
}
