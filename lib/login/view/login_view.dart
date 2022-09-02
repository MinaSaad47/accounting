import 'package:accounting/common/common.dart';
import 'package:accounting/login/cubit/login_cubit.dart';
import 'package:accounting/utils/utils.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.action == LoginAction.get &&
              state.status == LoginStatus.success) {
            Utils.toast(context, message: state.message);
            Navigator.of(context).popAndPushNamed('/');
          } else if (state.action == LoginAction.get &&
              state.status == LoginStatus.failure) {
            Utils.toast(
              context,
              message: state.message,
              level: ToastLevel.error,
            );
          }
        },
        builder: (context, state) {
          if (state.action == LoginAction.get &&
              state.status == LoginStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    AppLocalizations.of(context)!.login,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  FormBuilder(
                    key: formKey,
                    child: Column(
                      children: [
                        FormBuilderTextFieldWidget(
                          context,
                          name: AppLocalizations.of(context)!.userName,
                        ),
                        FormBuilderTextFieldWidget(
                          context,
                          name: AppLocalizations.of(context)!.password,
                          isPassword: true,
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state.action == LoginAction.login &&
                          state.status == LoginStatus.success) {
                        context.read<LoginCubit>().getCurrentUser();
                      } else if (state.action == LoginAction.login &&
                          state.status == LoginStatus.failure) {
                        Utils.toast(
                          context,
                          message: state.message,
                          level: ToastLevel.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      return MaterialButton(
                        onPressed: () async {
                          var formState = formKey.currentState;
                          if (formState != null && formState.validate()) {
                            formState.save();
                            var userModel = UserModel(
                              name: formState.value[
                                  AppLocalizations.of(context)!.userName],
                              password: formState.value[
                                  AppLocalizations.of(context)!.password],
                              value: 0,
                            );
                            context.read<LoginCubit>().loginUser(userModel);
                          }
                        },
                        color: Theme.of(context).colorScheme.secondary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.login,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(width: 5),
                            const Icon(Icons.login_outlined),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
