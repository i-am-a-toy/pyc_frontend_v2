import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class DefaultTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final double? fontSize;

  const DefaultTextButton({
    super.key,
    required this.onTap,
    required this.label,
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
