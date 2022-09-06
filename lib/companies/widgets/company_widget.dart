import 'package:accounting/common/common.dart';
import 'package:accounting/companies/view/company_info.dart';
import 'package:accounting_api/accounting_api.dart';
import 'package:flutter/material.dart';

class CompanyWidget extends StatelessWidget {
  final CompanyModel company;
  const CompanyWidget({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListItemWidget(
      title: company.id.toString(),
      onPressed: () {
        Navigator.of(context).push(CompanyInfo.route(context, company));
      },
      labels: [
        TextLabelWidget(
          icon: Icons.featured_play_list_outlined,
          title: AppLocalizations.of(context)!.registerNumber,
          content: company.registerNumber,
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
