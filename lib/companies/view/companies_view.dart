import 'package:accounting/common/common.dart';
import 'package:accounting/companies/companies.dart';
import 'package:accounting/companies/widgets/company_widget.dart';
import 'package:accounting/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompaniesView extends StatelessWidget {
  const CompaniesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = context.read<LoginCubit>().state.user!;
    return DefaultTabController(
      length: user.isAdmin ? 2 : 1,
      child: Scaffold(
        appBar: AppBarWidget(
          title: AppLocalizations.of(context)!.companies,
          tabBar: TabBar(
            tabs: [
              Tab(
                child: Text(AppLocalizations.of(context)!
                    .search(AppLocalizations.of(context)!.company)),
              ),
              if (user.isAdmin)
                Tab(
                  child: Text(
                    AppLocalizations.of(context)!
                        .add(AppLocalizations.of(context)!.company),
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
    );
  }
}

class _BuildSearchCompany extends StatelessWidget {
  const _BuildSearchCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SearchWidget(
            hintText: AppLocalizations.of(context)!
                .search(AppLocalizations.of(context)!.company),
            onChanged: (query) {
              if (query.isNotEmpty) {
                context
                    .read<CompaniesBloc>()
                    .add(CompaniesSearchRequested(query));
              }
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocConsumer<CompaniesBloc, CompaniesState>(
              listener: (context, state) {
                if (state is CompaniesGetInFailure) {
                  showToast(
                    context,
                    message: state.error,
                    level: ToastLevel.error,
                  );
                }
              },
              builder: (context, state) {
                if (state is CompaniesGetSuccess) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      var company = state.companies[index];
                      return CompanyWidget(company: company);
                    },
                    separatorBuilder: (context, index) => Container(
                      margin: const EdgeInsets.all(10),
                      height: 2,
                    ),
                    itemCount: state.companies.length,
                  );
                } else if (state is CompaniesGetInProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Container();
                }
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
