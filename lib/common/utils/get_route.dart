import 'package:get/get.dart';

Future<void> goToOffAllNamedWithDelay(String name, {Duration? duration}) async {
  await Future.delayed(duration ?? const Duration(milliseconds: 3000));
  Get.offAllNamed(name);
}
