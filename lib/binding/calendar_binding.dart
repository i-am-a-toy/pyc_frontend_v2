import 'package:get/get.dart';
import 'package:pyc/controllers/calendar/calendar_controller.dart';
import 'package:pyc/data/repositories/calendar/calendar_repository.dart';

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    final repository = Get.find<CalendarRepository>();
    Get.put<CalendarController>(CalendarController(repository));
  }
}
