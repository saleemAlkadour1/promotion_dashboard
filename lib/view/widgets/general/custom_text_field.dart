import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType inputType;
  final bool? enabled;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.inputType = TextInputType.text,
    this.enabled,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          enabled: enabled ?? true,
          labelText: label,
          border: buildBorder(),
          focusedBorder: buildBorder()),
      keyboardType: inputType,
    );
  }
}

OutlineInputBorder buildBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: Colors.blue,
      width: 2.0,
    ),
  );
}
