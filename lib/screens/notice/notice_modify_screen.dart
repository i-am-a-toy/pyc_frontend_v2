import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/validators/form/form_validator.dart';
import 'package:pyc/controllers/notice/notice_comment_controller.dart';
import 'package:pyc/screens/components/button/default_input_button.dart';
import 'package:pyc/screens/components/input/default_border_input_field.dart';

class NoticeModifyScreen extends StatelessWidget {
  static const routeName = '/notice_comment_modify';
  const NoticeModifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String comment = Get.arguments['content'] as String;
    int id = Get.arguments['id'] as int;
    int index = Get.arguments['index'] as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modify'),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              kDoubleHeightSizeBox,
              DefaultBorderInputField(
                onSaved: (value) => comment = value!,
                validate: requiredStringValidator,
                maxLine: 5,
                maxLength: 150,
                initialValue: Get.arguments['content'],
              ),
              kHeightSizeBox,
              DefaultInputButton(
                onPressed: () async {
                  if (formKey.currentState != null && !formKey.currentState!.validate()) return;
                  formKey.currentState!.save();
                  await Get.find<NoticeCommentController>().modifyComment(id, index, comment);
                  Get.back();
                },
                label: 'Modify',
              )
            ],
          ),
        ),
      ),
    );
  }
}
