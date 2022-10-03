import 'package:accounting/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormBuilderTextFieldWidget extends StatelessWidget {
  final String name;
  final String? value;
  final bool required;
  final bool isPassword;
  final String? Function(String?)? validator;
  const FormBuilderTextFieldWidget(
    BuildContext context, {
    Key? key,
    required this.name,
    this.value,
    this.required = false,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = double.infinity;
        if (constraints.maxWidth > 1200) {
          width = constraints.maxWidth / 3;
        } else if (constraints.maxWidth > 600) {
          width = constraints.maxWidth / 2;
        }
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: width,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderTextField(
              obscureText: isPassword,
              initialValue: value,
              name: name,
              decoration: InputDecoration(
                labelText: name,
                prefixIcon: required ? const Icon(Icons.star) : null,
              ),
              style: Theme.of(context).textTheme.headline6,
              validator: FormBuilderValidators.compose(
                [
                  if (required)
                    FormBuilderValidators.required(
                      errorText: l10n.expect(name),
                    ),
                  if (validator != null) validator!,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
