import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/validators/form/form_validator.dart';
import 'package:pyc/controllers/notice/notice_detail_controller.dart';
import 'package:pyc/screens/components/button/default_input_button.dart';
import 'package:pyc/screens/components/input/default_border_input_field.dart';

class NoticeModifyScreen extends StatelessWidget {
  static const routeName = '/notice_modify';
  const NoticeModifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int id = Get.arguments['id'];
    String title = Get.arguments['title'];
    String content = Get.arguments['content'];

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Modify')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kDoubleHeightSizeBox,
              const Text(
                'Title',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kHalfHeightSizeBox,
              DefaultBorderInputField(
                maxLine: 2,
                maxLength: 200,
                autoFocus: true,
                hintText: 'Please enter a title...',
                initialValue: title,
                onSaved: (val) => title = val!,
                validate: requiredStringValidator,
              ),
              kHeightSizeBox,
              const Text(
                'content',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kHalfHeightSizeBox,
              DefaultBorderInputField(
                maxLine: 10,
                maxLength: 200,
                autoFocus: true,
                hintText: 'Please enter a content...',
                initialValue: content,
                onSaved: (val) => content = val!,
                validate: requiredStringValidator,
              ),
              kHeightSizeBox,
              DefaultInputButton(
                onPressed: () async {
                  if (formKey.currentState != null && !formKey.currentState!.validate()) return;
                  formKey.currentState!.save();
                  await Get.find<NoticeDetailController>().modify(id, title, content);
                },
                label: 'Register',
              ),
              kDoubleHeightSizeBox,
            ],
          ),
        ),
      ),
    );
  }
}
