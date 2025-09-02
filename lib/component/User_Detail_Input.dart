import 'package:flutter/material.dart';

class UserDetailInput extends StatelessWidget {
  var nameController;
  String? hint;
  Color enabledBorderColor;
  Color focusedBorderColor;
  Color errorBorderColor;
  bool obscureText;
  Widget? PrefixIcon;
  FormFieldValidator<String>? Validator;
  UserDetailInput({
    super.key,
    required this.nameController,
    this.hint,
    this.enabledBorderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.errorBorderColor = Colors.red,
    this.obscureText = false,
    this.PrefixIcon,
    this.Validator,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      obscureText: obscureText,
      validator: Validator,
      decoration: InputDecoration(
        prefixIcon: PrefixIcon,
        labelText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enabledBorderColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorBorderColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorBorderColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
