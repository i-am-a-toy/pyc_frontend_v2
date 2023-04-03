import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/utils/get_snackbar.dart';
import 'package:pyc/data/models/calendar/responses/calendar_response.dart';
import 'package:pyc/data/repositories/calendar/calendar_repository_interface.dart';
import 'package:pyc/extension/datetime.dart';

class IndexCalendarController extends GetxController {
  final ICalendarRepository repository;
  final indexLimit = 3;
  IndexCalendarController(this.repository);

  // State
  List<CalendarResponse> _rows = [];
  int _count = 0;
  bool _isLoading = true;

  @override
  @mustCallSuper
  Future<void> onInit() async {
    super.onInit();
    await _fetchList();
  }

  Future<void> _fetchList() async {
    final startOfWeek = DateTime.now().getStartOfWeek();
    final endOfWeek = startOfWeek.getEndOfWeek();
    log('IndexCalendarController Init ${startOfWeek.toYYYYMMDD()} ~ ${endOfWeek.toYYYYMMDD()}');
    try {
      _isLoading == true ? _isLoading : true;
      update();

      final response = await repository.findByRange(startOfWeek, endOfWeek, offset: 0, limit: indexLimit);
      _rows = response.rows;
      _count = response.count;
      _isLoading = false;
      update();
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(Object e) {
    if (e is DioError) {
      _isLoading = false;
      update();

      // sever exception Message
      showGetXSnackBar('요청 실패', e.response!.data.message);
      return;
    }

    // Internal Service Error or Flutter Error
    showGetXSnackBar('요청 실패', '서버에 문제가 있습니다.\n관리자에게 문의해주세요.');
  }

  // getter
  bool get isLoading => _isLoading;
  List<CalendarResponse> get rows => _rows;
  int get count => _count;
}
