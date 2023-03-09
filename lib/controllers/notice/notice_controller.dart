import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/utils/get_snackbar.dart';
import 'package:pyc/data/models/notice/responses/notice_response.dart';
import 'package:pyc/data/repositories/notice/notice_repository_interface.dart';

class NoticeController extends GetxController {
  final INoticeRepository noticeRepository;
  final ScrollController _scrollController = ScrollController();
  NoticeController(this.noticeRepository);

  // STATE
  bool _isLoading = true;
  int _offset = 0;
  int _limit = 20;

  // SERVER STATE
  List<NoticeResponse> _rows = [];
  int _count = 0;
  bool _hasMore = true;

  ScrollController get scrollController => _scrollController;
  bool get isLoading => _isLoading;
  List<NoticeResponse> get rows => _rows;
  int get count => _count;
  bool get hasMore => _hasMore;

  @override
  @mustCallSuper
  void onInit() async {
    super.onInit();
    _scrollController.addListener(_listener);

    // FOR INDEX
    await _fetchList(offset: _offset, limit: 3);
  }

  Future<void> write(String title, String content) async {
    try {
      await noticeRepository.write(title, content);
      await refetch();
      Get.back();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> refetch() async {
    _offset = 0;
    _limit = 20;

    await _fetchList();
  }

  Future<void> _listener() async {
    if (_isLoading || !_hasMore) return;

    if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
      _hasMore = true;
      _offset += 20;
      _limit += 20;

      await Future.delayed(const Duration(microseconds: 500));
      final response = await noticeRepository.findAll(offset: _offset, limit: _limit);

      _rows.addAll(response.rows);
      _count = response.count;
      _hasMore = _rows.length < _count;

      update();
    }
  }

  Future<void> _fetchList({int offset = 0, int limit = 20}) async {
    log('Hit notice list fetch with offset: $offset, limit: $limit');
    try {
      _isLoading == true ? _isLoading : true;
      update();

      final response = await noticeRepository.findAll(offset: offset, limit: limit);
      _rows = response.rows;
      _count = response.count;
      _hasMore = _rows.length < response.count;
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
