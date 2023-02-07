import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class DefaultInputField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextInputType inputType;
  final bool obscureText;
  final bool autoFocus;
  final Widget? suffixIcon;

  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  const DefaultInputField({
    super.key,
    required this.label,
    this.hint,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.autoFocus = false,
    this.suffixIcon,
    required this.onSaved,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.start,
      obscureText: obscureText,
      keyboardType: inputType,
      cursorColor: kPrimaryColor,
      autofocus: autoFocus,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        suffixIconColor: kPrimaryColor,

        /// label
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 16.0,
          color: kGreyTextColor,
          height: 0.5,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hoverColor: kPointColor,

        /// hint
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 12.0,
          color: kGreyTextColor,
          height: 0.5,
        ),

        ///border
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: kPrimaryColor,
            width: 1.2,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: kGreyTextColor,
            width: 0.7,
          ),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: kGreyTextColor,
            width: 0.7,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.2,
          ),
        ),

        isDense: true,
      ),
    );
  }
}
