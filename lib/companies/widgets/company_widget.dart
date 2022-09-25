import 'package:accounting/common/common.dart';
import 'package:accounting/companies/view/company_info.dart';
import 'package:accounting/utils/utils.dart';
import 'package:accounting_api/accounting_api.dart';
import 'package:flutter/material.dart';

class CompanyWidget extends StatelessWidget {
  final CompanyModel company;
  final bool detailed;
  const CompanyWidget({
    Key? key,
    required this.company,
    this.detailed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListItemWidget(
      title: company.id.toString(),
      onPressed: !detailed
          ? () {
              Navigator.of(context).push(CompanyInfo.route(context, company));
            }
          : null,
      labels: [
        TextLabelWidget(
          icon: Icons.person_pin_outlined,
          title: AppLocalizations.of(context)!.owner,
          content: company.owner,
        ),
        TextLabelWidget(
          icon: Icons.featured_play_list_outlined,
          title: AppLocalizations.of(context)!.commercialFeature,
          content: company.commercialFeature,
        ),
        TextLabelWidget(
          icon: Icons.work_outline,
          title: AppLocalizations.of(context)!.isWorking,
          content: company.isWorking
              ? AppLocalizations.of(context)!.working
              : AppLocalizations.of(context)!.notWorking,
        ),
        if (detailed) ...[
          if (company.legalEntity != null)
            TextLabelWidget(
              icon: Icons.balance_outlined,
              title: AppLocalizations.of(context)!.legalEntity,
              content: company.legalEntity!,
            ),
          if (company.fileNumber != null)
            TextLabelWidget(
              icon: Icons.document_scanner_outlined,
              title: AppLocalizations.of(context)!.fileNumber,
              content: company.fileNumber!,
            ),
          if (company.registerNumber != null)
            TextLabelWidget(
              icon: Icons.app_registration_outlined,
              title: AppLocalizations.of(context)!.registerNumber,
              content: company.registerNumber!,
            ),
          if (company.startDate != null)
            TextLabelWidget(
              icon: Icons.date_range_outlined,
              title: AppLocalizations.of(context)!.startDate,
              content: Utils.formatDate(company.startDate!),
            ),
          if (company.stopDate != null)
            TextLabelWidget(
              icon: Icons.date_range_outlined,
              title: AppLocalizations.of(context)!.stopDate,
              content: Utils.formatDate(company.stopDate!),
            ),
          if (company.generalTaxMission != null)
            TextLabelWidget(
              icon: Icons.generating_tokens_rounded,
              title: AppLocalizations.of(context)!.generalTaxMission,
              content: company.generalTaxMission!,
            ),
          if (company.valueTaxMission != null)
            TextLabelWidget(
              icon: Icons.add_box_outlined,
              title: AppLocalizations.of(context)!.valueTaxMission,
              content: company.valueTaxMission!,
            ),
          if (company.activityNature != null)
            TextLabelWidget(
              icon: Icons.local_activity_outlined,
              title: AppLocalizations.of(context)!.activityNature,
              content: company.activityNature!,
            ),
          if (company.activityLocation != null)
            TextLabelWidget(
              icon: Icons.location_on_outlined,
              title: AppLocalizations.of(context)!.activityLocation,
              content: company.activityLocation!,
            ),
          if (company.username != null)
            TextLabelWidget(
              icon: Icons.person_outline,
              title: AppLocalizations.of(context)!.username,
              content: company.username!,
            ),
          if (company.email != null)
            TextLabelWidget(
              icon: Icons.email_outlined,
              title: AppLocalizations.of(context)!.email,
              content: company.email!,
            ),
        ],
      ],
    );
  }
}
