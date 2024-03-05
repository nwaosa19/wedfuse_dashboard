import 'package:flutter/material.dart';




class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.hintText,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  final String hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: Color(0XFFD5D8DE),
          ),
        ),
      ),
    );
  }
}
