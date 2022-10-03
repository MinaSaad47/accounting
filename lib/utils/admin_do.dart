part of 'utils.dart';

void _adminDo(
  BuildContext context, {
  bool requirePassword = true,
  required void Function() fn,
}) {
  final l10n = AppLocalizations.of(context)!;
  var user = context.read<LoginCubit>().state.user!;

  if (!user.isAdmin) {
    Utils.toast(
      context,
      message: l10n.unauth,
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
          hintText: l10n.password,
          validator: FormBuilderValidators.required(
            errorText: l10n.expect(l10n.password),
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
          message: l10n.notCorrect(l10n.password),
          level: ToastLevel.error,
        );
      }
    });
    return;
  }
  fn();
}
