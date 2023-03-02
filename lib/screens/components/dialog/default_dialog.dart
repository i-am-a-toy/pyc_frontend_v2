import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

void showDefaultDialog({
  required BuildContext context,
  required DialogType dialogType,
  required String title,
  required String desc,
  required VoidCallback onPressed,
}) =>
    AwesomeDialog(
      context: context,
      width: double.infinity,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: true,
      showCloseIcon: false,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      descTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      animType: AnimType.bottomSlide,
      dialogType: dialogType,
      title: title,
      desc: desc,
      btnCancel: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.red, width: 2),
        ),
        child: Text(
          'CANCEL',
          style: TextStyle(
            color: Colors.red.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      btnOk: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: kPrimaryColor, width: 2),
        ),
        child: const Text(
          'OK',
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ).show();
