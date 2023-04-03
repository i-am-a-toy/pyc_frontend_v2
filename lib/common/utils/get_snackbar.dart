import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void showGetXSnackBar(String title, String message, {bool isError = false}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(milliseconds: 1500),
    icon: const Icon(Icons.notifications_active_outlined),
    backgroundColor: isError ? Colors.red[700] : null,
  );
}
