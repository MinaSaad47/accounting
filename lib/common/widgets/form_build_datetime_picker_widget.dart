import 'package:accounting/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderDateTimePickerWidget extends StatelessWidget {
  final String name;
  final DateTime? value;
  final bool required;
  const FormBuilderDateTimePickerWidget(
    BuildContext context, {
    Key? key,
    required this.name,
    this.value,
    this.required = false,
  }) : super(key: key);

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
          constraints: BoxConstraints(maxWidth: width),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderDateTimePicker(
              decoration: InputDecoration(
                labelText: name,
                prefixIcon: required ? const Icon(Icons.star) : null,
              ),
              style: Theme.of(context).textTheme.headline6,
              initialValue: value,
              name: name,
              validator: (date) {
                if (!required || date != null) return null;
                return AppLocalizations.of(context)!.expect(name);
              },
            ),
          ),
        );
      },
    );
  }
}
