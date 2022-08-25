import 'package:accounting/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormBuilderTextFieldWidget extends StatelessWidget {
  final String name;
  final String? value;
  final bool required;
  final String? Function(String?)? validator;
  FormBuilderTextFieldWidget(
    BuildContext context, {
    Key? key,
    required this.name,
    this.value,
    this.required = true,
    String? Function(String?)? validator,
  })  : validator = validator ??
            FormBuilderValidators.required(
              errorText: AppLocalizations.of(context)!.expect(name),
            ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
              initialValue: value,
              name: name,
              decoration: InputDecoration(
                labelText: name,
              ),
              style: Theme.of(context).textTheme.headline6,
              validator: (text) {
                if (!required) return null;
                return validator != null ? validator!(text) : null;
              },
            ),
          ),
        );
      },
    );
  }
}
