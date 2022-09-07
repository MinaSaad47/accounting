import 'package:accounting/common/common.dart';
import 'package:accounting/companies/companies.dart';
import 'package:accounting/employees/view/employess_page.dart';
import 'package:accounting/login/cubit/login_cubit.dart';
import 'package:accounting/settings/settings.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

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
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      AvatarGlow(
                        glowColor: Theme.of(context).primaryColor,
                        endRadius: 60,
                        child: Material(
                          elevation: 8,
                          shape: const CircleBorder(),
                          child: CircleAvatar(
                            radius: 40,
                            child: Icon(
                              state.user!.isAdmin
                                  ? Icons.admin_panel_settings_outlined
                                  : Icons.person_outline,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.person_outline),
                              const SizedBox(width: 5),
                              Text(state.user!.name),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.currency_exchange_outlined),
                              const SizedBox(width: 5),
                              Text('${state.user!.value}'),
                            ],
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  DrawerItem(
                    text: AppLocalizations.of(context)!.companies,
                    icon: Icons.account_balance_outlined,
                    route: CompaniesPage.route(),
                  ),
                  DrawerItem(
                    text: AppLocalizations.of(context)!.employees,
                    icon: Icons.people_outline,
                    route: EmployessPage.route(),
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
              ListTile(
                title: const Text('About'),
                leading: const Icon(Icons.info_outline),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: AppLocalizations.of(context)!.appName,
                    applicationIcon: SvgPicture.asset(
                      'assets/images/logo.svg',
                      color: Theme.of(context).primaryColor,
                      fit: BoxFit.contain,
                    ),
                    applicationVersion: Constants.appVersion,
                    children: [
                      const ListTile(
                        title: Text(Constants.authorName),
                        leading: Icon(Icons.person),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        onTap: () async {
                          var uri = Uri.parse(Constants.github);
                          if (await canLaunchUrl(uri)) {
                            launchUrl(uri);
                          }
                        },
                        title: const Text('github'),
                        leading: const Icon(Icons.code),
                      )
                    ],
                  );
                },
              )
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
