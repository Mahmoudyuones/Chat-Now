import 'package:chat_app/shared/appthem.dart';
import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Appthem.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      validator: validator,
    );
  }
}
