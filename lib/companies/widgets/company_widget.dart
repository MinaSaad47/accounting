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
    final l10n = AppLocalizations.of(context)!;
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
          title: l10n.owner,
          content: company.owner,
        ),
        TextLabelWidget(
          icon: Icons.featured_play_list_outlined,
          title: l10n.commercialFeature,
          content: company.commercialFeature,
        ),
        TextLabelWidget(
          icon: Icons.work_outline,
          title: l10n.isWorking,
          content: company.isWorking ? l10n.working : l10n.notWorking,
        ),
        if (detailed) ...[
          if (company.legalEntity != null)
            TextLabelWidget(
              icon: Icons.balance_outlined,
              title: l10n.legalEntity,
              content: company.legalEntity!,
            ),
          if (company.fileNumber != null)
            TextLabelWidget(
              icon: Icons.document_scanner_outlined,
              title: l10n.fileNumber,
              content: company.fileNumber!,
            ),
          if (company.registerNumber != null)
            TextLabelWidget(
              icon: Icons.app_registration_outlined,
              title: l10n.registerNumber,
              content: company.registerNumber!,
            ),
          if (company.startDate != null)
            TextLabelWidget(
              icon: Icons.date_range_outlined,
              title: l10n.startDate,
              content: Utils.formatDate(company.startDate!),
            ),
          if (company.stopDate != null)
            TextLabelWidget(
              icon: Icons.date_range_outlined,
              title: l10n.stopDate,
              content: Utils.formatDate(company.stopDate!),
            ),
          if (company.generalTaxMission != null)
            TextLabelWidget(
              icon: Icons.generating_tokens_rounded,
              title: l10n.generalTaxMission,
              content: company.generalTaxMission!,
            ),
          if (company.valueTaxMission != null)
            TextLabelWidget(
              icon: Icons.add_box_outlined,
              title: l10n.valueTaxMission,
              content: company.valueTaxMission!,
            ),
          if (company.activityNature != null)
            TextLabelWidget(
              icon: Icons.local_activity_outlined,
              title: l10n.activityNature,
              content: company.activityNature!,
            ),
          if (company.activityLocation != null)
            TextLabelWidget(
              icon: Icons.location_on_outlined,
              title: l10n.activityLocation,
              content: company.activityLocation!,
            ),
          if (company.username != null)
            TextLabelWidget(
              icon: Icons.person_outline,
              title: l10n.username,
              content: company.username!,
            ),
          if (company.email != null)
            TextLabelWidget(
              icon: Icons.email_outlined,
              title: l10n.email,
              content: company.email!,
            ),
        ],
      ],
    );
  }
}
