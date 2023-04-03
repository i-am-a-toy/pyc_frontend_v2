import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class DefaultBorderInputField extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validate;
  final bool? autoFocus;
  final int? maxLength;
  final int? maxLine;
  final bool? isRounded;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final String? hintText;

  const DefaultBorderInputField({
    super.key,
    required this.onSaved,
    required this.validate,
    this.autoFocus = false,
    this.isRounded = false,
    this.maxLength,
    this.initialValue,
    this.maxLine,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus!,
      maxLength: maxLength,
      cursorColor: kPrimaryColor,
      initialValue: initialValue,
      maxLines: maxLine,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(isRounded! ? 40 : kDefaultValue / 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kGreyBorderColor, width: 2.0),
          borderRadius: BorderRadius.circular(isRounded! ? 40 : kDefaultValue / 2),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(isRounded! ? 40 : kDefaultValue / 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(isRounded! ? 40 : kDefaultValue / 2),
        ),
        isDense: true,
        hintStyle: const TextStyle(fontSize: 14.0),
        hintText: hintText,
        counterText: '',
      ),
      onSaved: onSaved,
      validator: validate,
    );
  }
}
