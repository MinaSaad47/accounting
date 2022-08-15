import 'package:accounting/common/common.dart';
import 'package:accounting/companies/companies.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              DrawerItem(
                text: AppLocalizations.of(context)!.companies,
                icon: Icons.account_balance_outlined,
                route: CompaniesPage.route(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final MaterialPageRoute route;
  const DrawerItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Scaffold.of(context).closeDrawer();
        Navigator.of(context).popUntil((route) => route.settings.name == '/');
        Navigator.of(context).push(route);
      },
      leading: Icon(icon),
      title: Text(text),
    );
  }
}
