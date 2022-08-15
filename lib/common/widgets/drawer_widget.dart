import 'package:accounting/common/common.dart';
import 'package:accounting/companies/companies.dart';
import 'package:accounting/settings/settings.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  DrawerItem(
                    text: AppLocalizations.of(context)!.companies,
                    icon: Icons.account_balance_outlined,
                    route: CompaniesPage.route(),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Theme.of(context).primaryColor.withOpacity(0.4),
                  height: 2,
                ),
              ),
              DrawerItem(
                text: AppLocalizations.of(context)!.settings,
                icon: Icons.settings_outlined,
                route: SettingsPage.route(),
              ),
              const SizedBox(height: 40),
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
