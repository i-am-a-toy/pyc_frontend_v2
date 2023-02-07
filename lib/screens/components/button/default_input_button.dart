import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class DefaultInputButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const DefaultInputButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        foregroundColor: kSecondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kDefaultValue / 2)),
        minimumSize: const Size(double.infinity, kDefaultValue * 3),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: kDefaultValue * 0.75,
        ),
      ),
    );
  }
}
