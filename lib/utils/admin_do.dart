part of 'utils.dart';

void _adminDo(BuildContext context, void Function() function) {
  var user = context.read<LoginCubit>().state.user!;

  if (!user.isAdmin) {
    Utils.toast(
      context,
      message: AppLocalizations.of(context)!.unauth,
      level: ToastLevel.warning,
    );
    return;
  }

  showTextInputDialog(
    context: context,
    textFields: [
      DialogTextField(
        obscureText: true,
        hintText: AppLocalizations.of(context)!.passport,
        validator: FormBuilderValidators.required(
          errorText: AppLocalizations.of(context)!
              .expect(AppLocalizations.of(context)!.passport),
        ),
      ),
    ],
  ).then((inputs) {
    var answer = inputs?[0];
    if (answer != null && answer == user.password) {
      function();
    } else {
      Utils.toast(
        context,
        message: AppLocalizations.of(context)!
            .notCorrect(AppLocalizations.of(context)!.passport),
        level: ToastLevel.error,
      );
    }
  });
}
