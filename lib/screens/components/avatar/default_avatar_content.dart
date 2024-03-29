import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/screens/components/avatar/default_circle_avatar.dart';

class DefaultAvatarContent extends StatelessWidget {
  final DefaultCircleAvatar avatar;
  final String title;
  final String content;
  final String? subContent;
  final Widget? suffix;
  final bool? overflow;
  const DefaultAvatarContent({
    super.key,
    required this.avatar,
    required this.title,
    required this.content,
    this.subContent,
    this.suffix,
    this.overflow = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          avatar,
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
                  maxLines: overflow! ? 2 : null,
                  overflow: overflow! ? TextOverflow.ellipsis : null,
                ),
                kQuarterHeightSizedBox,
                RichText(
                  overflow: overflow! ? TextOverflow.ellipsis : TextOverflow.visible,
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
