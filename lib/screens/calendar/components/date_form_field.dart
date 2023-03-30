import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/constants/constants.dart';

class DateFormFiled extends FormField<DateTime> {
  DateFormFiled({
    required BuildContext context,
    required FormFieldSetter<DateTime> onConfirm,
    required DateTime initialValue,
    required bool isAllDay,
    required String title,
    FormFieldSetter<DateTime>? onSaved,
    FormFieldValidator<DateTime>? validator,
    DateTime? minTime,
    DateTime? maxTime,
    Key? key,
  }) : super(
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          key: key,
          builder: (FormFieldState<DateTime> state) {
            return InkWell(
              onTap: () => isAllDay
                  ? DatePicker.showDatePicker(
                      context,
                      locale: LocaleType.ko,
                      onConfirm: onConfirm,
                      currentTime: initialValue,
                      minTime: minTime,
                      maxTime: maxTime,
                      theme: _getTheme(),
                    )
                  : DatePicker.showDateTimePicker(
                      context,
                      locale: LocaleType.ko,
                      currentTime: initialValue,
                      onConfirm: onConfirm,
                      minTime: minTime,
                      maxTime: maxTime,
                      theme: _getTheme(),
                    ),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16.0,
                      ),
                    ),
                    kHalfHeightSizeBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('yyyy년 MM월 dd일').format(initialValue).toString(),
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        kWidthSizeBox,
                        if (!isAllDay)
                          Text(
                            DateFormat('a hh:mm').format(initialValue).toString(),
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),
                          ),
                      ],
                    ),
                    if (state.hasError)
                      Builder(
                        builder: (BuildContext context) => Text(
                          '${state.errorText}',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12.0,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            );
          },
        );

  static DatePickerTheme _getTheme() {
    return DatePickerTheme(
      itemStyle: const TextStyle(
        color: kPrimaryColor,
      ),
      doneStyle: const TextStyle(
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
      cancelStyle: TextStyle(
        color: Colors.red.shade700,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
