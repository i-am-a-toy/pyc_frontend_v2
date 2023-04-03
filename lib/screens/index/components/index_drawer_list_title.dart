import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class IndexDrawerListTitle extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const IndexDrawerListTitle({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        icon,
        color: Colors.white,
        width: kDefaultValue * 2,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      onTap: onTap,
    );
  }
}
