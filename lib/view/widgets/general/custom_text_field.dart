import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType inputType;
  final bool? readOnly;
  final bool? enabled;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final MouseCursor? mouseCursor;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.inputType = TextInputType.text,
    this.readOnly,
    this.enabled,
    this.onChanged,
    this.onTap,
    this.validator,
    this.mouseCursor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      mouseCursor: mouseCursor,
      readOnly: readOnly ?? false,
      onChanged: onChanged,
      onTap: onTap,
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
