import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderDropdownWidget extends StatelessWidget {
  final String name;
  final String initialValue;
  final List<String> items;
  const FormBuilderDropdownWidget({
    Key? key,
    required this.initialValue,
    required this.items,
    required this.name,
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
            child: FormBuilderDropdown(
              name: name,
              initialValue: initialValue,
              style: Theme.of(context).textTheme.headline4,
              decoration: InputDecoration(
                labelText: name,
              ),
              items: items
                  .map((e) => DropdownMenuItem(
                      value: e, child: FittedBox(child: Text(e))))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
