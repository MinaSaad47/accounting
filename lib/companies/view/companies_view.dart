import 'package:accounting/common/common.dart';
import 'package:accounting/companies/companies.dart';
import 'package:accounting/companies/widgets/company_widget.dart';
import 'package:accounting/login/cubit/login_cubit.dart';
import 'package:accounting/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompaniesView extends StatelessWidget {
  const CompaniesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    var user = context.read<LoginCubit>().state.user!;
    return BlocListener<CompaniesBloc, CompanyState>(
      listener: (context, state) {
        switch (state.status) {
          case CompanyStatus.failure:
            Utils.toast(
              context,
              message: state.message,
              level: ToastLevel.error,
            );
            break;
          case CompanyStatus.success:
            switch (state.action) {
              case CompanyAction.delete:
              case CompanyAction.save:
                Navigator.of(context).pop();
                Utils.toast(
                  context,
                  message: state.message,
                );
                break;
              default:
            }
            break;
          default:
        }
      },
      child: DefaultTabController(
        length: user.isAdmin ? 2 : 1,
        child: Scaffold(
          appBar: AppBarWidget(
            title: l10n.companies,
            tabBar: TabBar(
              tabs: [
                Tab(
                  child: Text(l10n.search(l10n.company)),
                ),
                if (user.isAdmin)
                  Tab(
                    child: Text(
                      l10n.add(l10n.company),
                    ),
                  ),
              ],
            ),
          ),
          drawer: const DrawerWidget(),
          body: TabBarView(
            children: [
              const _BuildSearchCompany(),
              if (user.isAdmin) const _BuildAddCompany(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildSearchCompany extends StatelessWidget {
  const _BuildSearchCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SearchWidget(
            hintText: l10n.search(l10n.company),
            onChanged: (query) {
              if (query.isNotEmpty) {
                context
                    .read<CompaniesBloc>()
                    .add(CompanySearchRequested(query));
              }
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<CompaniesBloc, CompanyState>(
              buildWhen: (prev, curr) => curr.list.length != prev.list.length,
              builder: (context, state) {
                if (state.action == CompanyAction.get) {
                  if (state.status == CompanyStatus.success) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        var company = state.list[index];
                        return CompanyWidget(company: company);
                      },
                      separatorBuilder: (context, index) => Container(
                        margin: const EdgeInsets.all(10),
                        height: 2,
                      ),
                      itemCount: state.list.length,
                    );
                  } else if (state.status == CompanyStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
                return Container();
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
    return const CompanyEditWidget();
  }
}
