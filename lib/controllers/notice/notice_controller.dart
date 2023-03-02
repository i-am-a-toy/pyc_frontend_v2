import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/utils/get_snackbar.dart';
import 'package:pyc/data/models/notice/responses/notice_response.dart';
import 'package:pyc/data/repositories/notice/notice_repository_interface.dart';

class NoticeController extends GetxController {
  final INoticeRepository noticeRepository;
  NoticeController(this.noticeRepository);

  // STATE
  bool _isLoading = true;

  // SERVER STATE
  List<NoticeResponse> _rows = [];
  int _count = 0;

  bool get isLoading => _isLoading;
  List<NoticeResponse> get rows => _rows;
  int get count => _count;

  @override
  @mustCallSuper
  void onInit() async {
    super.onInit();
    const int initOffset = 0;
    const int initLimit = 3;
    await _fetchList(offset: initOffset, limit: initLimit);
  }

  Future<void> refetch() async {
    await _fetchList();
  }

  Future<void> _fetchList({int offset = 0, int limit = 20}) async {
    try {
      _isLoading == true ? _isLoading : true;
      update();

      final response = await noticeRepository.findAll(offset: offset, limit: limit);
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
      showGetXSnackBar('요청 실패', e.message);
      return;
    }

    // Internal Service Error or Flutter Error
    showGetXSnackBar('요청 실패', '서버에 문제가 있습니다.\n관리자에게 문의해주세요.');
  }
}
