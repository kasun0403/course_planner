import 'package:course_planner/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  const CustomInputField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.grey),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: darkBlue),
            ),
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 13, vertical: 14)),
      ),
    );
  }
}
