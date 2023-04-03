import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/validators/form/form_validator.dart';
import 'package:pyc/controllers/index/fetch_me_controller.dart';
import 'package:pyc/controllers/notice/notice_comment_controller.dart';
import 'package:pyc/controllers/notice/notice_detail_controller.dart';
import 'package:pyc/data/models/notice/responses/notice_comment_response.dart';
import 'package:pyc/extension/datetime.dart';
import 'package:pyc/screens/components/avatar/default_avatar_content.dart';
import 'package:pyc/screens/components/avatar/default_circle_avatar.dart';
import 'package:pyc/screens/components/button/default_text_button.dart';
import 'package:pyc/screens/components/dialog/default_dialog.dart';
import 'package:pyc/screens/components/input/default_border_input_field.dart';
import 'package:pyc/screens/components/spacer/default_spacer.dart';
import 'package:pyc/screens/notice/notice_comment_modify_screen.dart';
import 'package:pyc/screens/notice/notice_modify_screen.dart';

class NoticeDetailScreen extends StatelessWidget {
  static const routeName = '/notice_detail';
  const NoticeDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final noticeDetailController = Get.find<NoticeDetailController>();
    final int id = Get.arguments['id'];
    final bool autoFocus = Get.arguments['autoFocus'] ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notice'),
        backgroundColor: kPrimaryColor,
        // Notice modify & delete permission only manager
        actions: Get.find<FetchMeController>().myProfile.role.isManager()
            ? [
                // Notice Modify
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () async {
                    // Detail refetch & go modify screen
                    await noticeDetailController.refetch();
                    Get.toNamed(NoticeModifyScreen.routeName, arguments: {
                      "id": noticeDetailController.notice.id,
                      "title": noticeDetailController.notice.title,
                      "content": noticeDetailController.notice.content,
                    });
                  },
                ),
                // Notice Delete
                IconButton(
                  icon: const Icon(Icons.close_outlined),
                  onPressed: () => showDefaultDialog(
                    context: context,
                    dialogType: DialogType.question,
                    title: 'Question',
                    desc: '공지사항을 삭제하시겠습니까?',
                    onPressed: () async {
                      Navigator.of(context).pop();
                      Get.find<NoticeDetailController>().deleteById();
                    },
                  ),
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
        child: InkWell(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            children: [
              kDoubleHeightSizeBox,
              GetBuilder<NoticeDetailController>(
                builder: (controller) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _Notice(),
                      kHeightSizeBox,
                      DefaultSpacer(),
                      kHeightSizeBox,
                      _NoticeComment(),
                      kDoubleHeightSizeBox,
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: NoticeDetailBottomSheet(
        autoFocus: autoFocus,
        noticeId: id,
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeDetailController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Notice Header
          DefaultAvatarContent(
            avatar: const DefaultCircleAvatar(
              child: Icon(
                Icons.person_outline_outlined,
                size: kDefaultValue * 2,
                color: Colors.white,
              ),
            ),
            title: controller.notice.title,
            content: '작성자 | ${controller.notice.creator.name} ',
            subContent: controller.notice.createdAt.getDifferenceNow(),
          ),
          kHeightSizeBox,

          /// Notice Body
          Text(
            controller.notice.content,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoticeComment extends StatelessWidget {
  const _NoticeComment();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeCommentController>(
      builder: (controller) {
        return controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Notice Comment Count & More Button
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '댓글 ${controller.isLoading ? 0 : controller.count}개',
                        style: const TextStyle(
                          color: kGreyTextColor,
                          fontSize: 12.0,
                        ),
                      ),
                      if (controller.hasMore) ...[
                        kHeightSizeBox,
                        DefaultTextButton(
                          onTap: () async => controller.moreComment(),
                          label: '댓글 더보기',
                        )
                      ]
                    ],
                  ),

                  kHeightSizeBox,

                  /// Comment List
                  NoticeCommentList(
                    rows: controller.rows,
                  )
                ],
              );
      },
    );
  }
}

class NoticeCommentList extends StatelessWidget {
  final List<NoticeCommentResponse> rows;
  const NoticeCommentList({
    super.key,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    final fetchMeController = Get.find<FetchMeController>();
    final commentController = Get.find<NoticeCommentController>();

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (int i = 0; i < rows.length; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultAvatarContent(
                avatar: const DefaultCircleAvatar(
                  child: Icon(
                    Icons.person_outline_outlined,
                    size: kDefaultValue * 2,
                    color: Colors.white,
                  ),
                ),
                title: rows[i].creator.name,
                content: rows[i].content,
                subContent: '\n${rows[i].createdAt.getDifferenceNow()}',
                suffix: fetchMeController.myProfile.id == rows[i].creator.id
                    ? Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit_note_outlined, color: kPrimaryColor),
                            onPressed: () => Get.toNamed(
                              NoticeCommentModifyScreen.routeName,
                              arguments: {
                                'id': rows[i].id,
                                'content': rows[i].content,
                                'index': i,
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete_outline_outlined, color: Colors.red.shade700),
                            onPressed: () => showDefaultDialog(
                              context: context,
                              dialogType: DialogType.question,
                              title: 'Question',
                              desc: '댓글을 삭제하시겠습니까?',
                              onPressed: () async {
                                Navigator.of(context).pop();
                                commentController.deleteComment(rows[i].id, i);
                              },
                            ),
                          )
                        ],
                      )
                    : null,
              ),
              if (rows.length - 1 > i) ...[
                kHalfHeightSizeBox,
                const DefaultSpacer(height: 2.0),
                kHalfHeightSizeBox,
              ]
            ],
          ),
      ],
    );
  }
}

class NoticeDetailBottomSheet extends StatelessWidget {
  final int noticeId;
  final bool autoFocus;

  const NoticeDetailBottomSheet({
    Key? key,
    required this.noticeId,
    required this.autoFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String comment = '';
    return Form(
      key: formKey,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultValue,
          vertical: kDefaultValue / 2,
        ),
        child: DefaultBorderInputField(
          autoFocus: autoFocus,
          onSaved: (val) => comment = val!,
          validate: requiredStringValidator,
          isRounded: true,
          maxLength: 200,
          prefixIcon: const Padding(
            padding: EdgeInsets.only(right: kDefaultValue / 2),
            child: DefaultCircleAvatar(
              child: Icon(
                Icons.person_outline_outlined,
                size: kDefaultValue * 2,
                color: Colors.white,
              ),
            ),
          ),
          suffixIcon: InkWell(
            onTap: () async {
              if (formKey.currentState != null && !formKey.currentState!.validate()) return;
              formKey.currentState!.save();
              await Get.find<NoticeCommentController>().comment(noticeId, comment);
              formKey.currentState!.reset();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Image.asset(
              'assets/icons/send_icon.png',
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
