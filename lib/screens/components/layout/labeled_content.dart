import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/screens/components/button/default_text_button.dart';

class LabeledContent extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Widget content;

  const LabeledContent({
    super.key,
    required this.onTap,
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.amber,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextButton(onTap: onTap, label: label),
          kHalfHeightSizeBox,
          content,
        ],
      ),
    );
  }
}
