part of 'utils.dart';

void _adminDo(
  BuildContext context, {
  bool requirePassword = true,
  required void Function() fn,
}) {
  var user = context.read<LoginCubit>().state.user!;

  if (!user.isAdmin) {
    Utils.toast(
      context,
      message: AppLocalizations.of(context)!.unauth,
      level: ToastLevel.warning,
    );
    return;
  }

  if (requirePassword) {
    showTextInputDialog(
      context: context,
      textFields: [
        DialogTextField(
          obscureText: true,
          hintText: AppLocalizations.of(context)!.password,
          validator: FormBuilderValidators.required(
            errorText: AppLocalizations.of(context)!
                .expect(AppLocalizations.of(context)!.password),
          ),
        ),
      ],
    ).then((inputs) {
      var answer = inputs?[0];
      if (answer != null && answer == user.password) {
        fn();
      } else {
        Utils.toast(
          context,
          message: AppLocalizations.of(context)!
              .notCorrect(AppLocalizations.of(context)!.password),
          level: ToastLevel.error,
        );
      }
    });
    return;
  }
  fn();
}
