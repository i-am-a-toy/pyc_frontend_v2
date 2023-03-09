import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/extension/datetime.dart';
import 'package:pyc/screens/components/avatar/default_avatar_content.dart';
import 'package:pyc/screens/components/avatar/default_circle_avatar.dart';
import 'package:pyc/screens/components/spacer/default_spacer.dart';

class NoticeCard extends StatelessWidget {
  final String title;
  final String writerName;
  final String content;
  final DateTime createdAt;
  final VoidCallback cardTap;
  final VoidCallback buttonTap;

  const NoticeCard({
    super.key,
    required this.title,
    required this.writerName,
    required this.content,
    required this.createdAt,
    required this.cardTap,
    required this.buttonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kDefaultValue / 2),
      ),
      child: InkWell(
        onTap: cardTap,
        child: Container(
          margin: const EdgeInsets.fromLTRB(kDefaultValue, kDefaultValue, kDefaultValue, kDefaultValue / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultAvatarContent(
                    avatar: const DefaultCircleAvatar(child: Icon(Icons.person_outline_outlined)),
                    title: title,
                    content: '작성자 | $writerName',
                    subContent: createdAt.getDifferenceNow().toString(),
                    overflow: true,
                  ),
                  kHeightSizeBox,
                  Text(
                    content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                  kHalfHeightSizeBox,
                ],
              ),
              Column(
                children: [
                  const DefaultSpacer(
                    height: 2.0,
                  ),
                  kHalfHeightSizeBox,
                  InkWell(
                    onTap: buttonTap,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.message_outlined,
                              color: kPrimaryColor,
                            ),
                            kQuarterWidthSizedBox,
                            Text(
                              '댓글쓰기',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
