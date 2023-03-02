import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class DefaultAppBarBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const DefaultAppBarBackButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.arrow_back_ios_outlined,
        size: kDefaultValue * 1.2,
      ),
    );
  }
}
