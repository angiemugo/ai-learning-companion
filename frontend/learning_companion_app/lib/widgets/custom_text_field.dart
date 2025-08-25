import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_companion_app/utils/app_constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final bool enabled;
  final int? maxLength;
  final bool autocorrect;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.enabled = true,
    this.maxLength,
    this.autocorrect = true,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: labelText,
      hint: hintText,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          counterText: maxLength != null ? null : '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          ),
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        onChanged: onChanged,
        enabled: enabled,
        maxLength: maxLength,
        autocorrect: autocorrect,
        textCapitalization: keyboardType == TextInputType.emailAddress
            ? TextCapitalization.none
            : TextCapitalization.words,
      ),
    );
  }
}
