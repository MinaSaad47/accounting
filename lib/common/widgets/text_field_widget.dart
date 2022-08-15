import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String expect;
  final TextInputType type;
  final IconData? icon;
  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.expect,
    required this.label,
    this.type = TextInputType.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: (text) => text == null || text.isEmpty ? expect : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
    );
  }
}
