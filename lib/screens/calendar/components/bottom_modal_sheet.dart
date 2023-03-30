import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/validators/form/form_validator.dart';
import 'package:pyc/controllers/calendar/calendar_controller.dart';
import 'package:pyc/data/models/calendar/responses/calendar_response.dart';
import 'package:pyc/extension/datetime.dart';
import 'package:pyc/screens/calendar/components/date_form_field.dart';
import 'package:pyc/screens/components/input/default_border_input_field.dart';

getBottomModal({
  required BuildContext context,
  required bool isDetail,
  VoidCallback? onCloseTap,
  Function(String, String)? onRegisterTap,
  Function(int, String, String)? onModifyTap,
  Function(int)? onDeleteTap,
  CalendarResponse? data,
}) {
  String title = data != null ? data.title : '';
  String content = data != null ? data.content : '';

  // Bottom Modal Sheet
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,

    /// Border Shape
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),

    builder: (context) {
      return GetBuilder<CalendarController>(
        builder: (controller) => Form(
          key: formKey,
          child: InkWell(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.75,
              child: GetBuilder<CalendarController>(
                builder: (controller) => SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    kDefaultValue,
                    kDefaultValue,
                    kDefaultValue,
                    MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () async => data == null ? onCloseTap : onDeleteTap,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              data == null ? CupertinoIcons.clear_circled : CupertinoIcons.delete,
                              color: kPrimaryColor,
                              size: kDefaultValue * 1.5,
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () async => data == null ? onRegisterTap!(title, content) : onModifyTap,
                            icon: Icon(
                              data == null ? CupertinoIcons.check_mark_circled : CupertinoIcons.pen,
                              color: kPrimaryColor,
                              size: kDefaultValue * 1.5,
                            ),
                          ),
                        ],
                      ),
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
                        autoFocus: isDetail ? false : true,
                        hintText: 'Please enter a title...',
                        onSaved: (val) => title = val!,
                        validate: requiredStringValidator,
                        initialValue: data?.title,
                      ),
                      kHeightSizeBox,
                      const Text(
                        'Content',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      kHalfHeightSizeBox,
                      DefaultBorderInputField(
                        maxLine: 5,
                        hintText: 'Please enter a content...',
                        onSaved: (val) => content = val!,
                        validate: requiredStringValidator,
                        initialValue: data?.content,
                      ),
                      kHeightSizeBox,

                      /// isAllDay switch
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'All Day',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                            value: data?.isAllDay ?? controller.isAllDay,
                            onChanged: controller.toggleIsAllDay,
                            activeColor: kPrimaryColor,
                          ),
                        ],
                      ),
                      kHeightSizeBox,
                      DateFormFiled(
                        context: context,
                        onConfirm: controller.onConfirmStart,
                        initialValue: data?.start ?? controller.start,
                        isAllDay: data?.isAllDay ?? controller.isAllDay,
                        title: '시작',
                      ),
                      kHeightSizeBox,
                      DateFormFiled(
                        context: context,
                        minTime: data?.start ?? controller.start,
                        onConfirm: controller.onConfirmEnd,
                        initialValue: data?.end ?? controller.end,
                        isAllDay: data?.isAllDay ?? controller.isAllDay,
                        title: '종료',
                        validator: (value) {
                          final inputEnd = data != null ? data.end : controller.end;
                          return inputEnd.isAfterOrEqualTo(value!) ? null : '종료는 시작과 같거나 이 후 시점이여야 합니다.';
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  ).whenComplete(
    () => Get.find<CalendarController>().resetBottomSheet(),
  );
}
