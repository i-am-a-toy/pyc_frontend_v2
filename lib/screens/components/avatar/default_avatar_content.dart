import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/screens/components/avatar/default_circle_avatar.dart';

class DefaultAvatarContent extends StatelessWidget {
  final DefaultCircleAvatar avatar;
  final String title;
  final String content;
  final String? subContent;
  final Widget? suffix;
  const DefaultAvatarContent({
    super.key,
    required this.avatar,
    required this.title,
    required this.content,
    required this.subContent,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const DefaultCircleAvatar(
            child: Icon(
              Icons.person_outline_outlined,
              size: kDefaultValue * 2,
              color: Colors.white,
            ),
          ),
          kWidthSizeBox,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                kQuarterHeightSizedBox,
                RichText(
                  text: TextSpan(
                    text: content,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: kGreyTextColor,
                    ),
                    children: subContent != null
                        ? [
                            TextSpan(
                              text: subContent,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: kGreyTextColor,
                              ),
                            ),
                          ]
                        : null,
                  ),
                ),
              ],
            ),
          ),
          if (suffix != null) suffix!
        ],
      ),
    );
  }
}
