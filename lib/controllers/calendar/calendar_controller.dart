import 'package:get/get.dart';

class CalendarController extends GetxController {
  bool _isLoading = true;
  DateTime _focusDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  DateTime get focusDay => _focusDay;
  DateTime get selectedDay => _selectedDay;
  bool get isLoading => _isLoading;
}
