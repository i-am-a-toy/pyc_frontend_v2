import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class DefaultRoundedLabel extends StatelessWidget {
  final String label;

  const DefaultRoundedLabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 80.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: kPrimaryColor,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(50.0),
      ),
      height: 30.0,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
