import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class DefaultCircleAvatar extends StatelessWidget {
  final double? radius;
  final Color? backgroundColor;
  final ImageProvider? backgroundImage;
  final Widget? child;

  const DefaultCircleAvatar({
    super.key,
    this.radius = 24.0,
    this.backgroundColor = kPrimaryColor,
    this.backgroundImage,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: radius,
      backgroundColor: backgroundColor,
      backgroundImage: backgroundImage,
      child: child,
    );
  }
}
