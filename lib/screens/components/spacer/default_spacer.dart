import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class DefaultSpacer extends StatelessWidget {
  final double? height;
  const DefaultSpacer({
    Key? key,
    this.height = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: kWhiteGreyTextColor,
    );
  }
}
