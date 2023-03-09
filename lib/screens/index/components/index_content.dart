import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class IndexContent extends StatelessWidget {
  final IconData icon;
  final String content;
  final String? subContent;
  final VoidCallback? onTap;

  const IndexContent({
    Key? key,
    required this.icon,
    required this.content,
    this.onTap,
    this.subContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
      margin: const EdgeInsets.only(bottom: kDefaultValue / 2),
      width: double.infinity,
      height: 80.0,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(kDefaultValue),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 24.0,
                  backgroundColor: kPrimaryColor,
                  child: Icon(
                    icon,
                    size: kDefaultValue * 1.75,
                    color: Colors.white,
                  ),
                ),
                kHalfWidthSizedBox,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        content,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      if (subContent != null)
                        Column(
                          children: [
                            kQuarterHeightSizedBox,
                            Text(
                              subContent!,
                              style: const TextStyle(
                                color: kPrimaryColor,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: const Icon(
              Icons.keyboard_arrow_right_outlined,
              size: kDefaultValue * 2,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
