import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/utils/get_snackbar.dart';
import 'package:pyc/data/models/notice/responses/notice_comment_response.dart';
import 'package:pyc/data/repositories/notice/notice_comment_repository_interface.dart';

class NoticeCommentController extends GetxController {
  final INoticeCommentRepository commentRepository;
  final int id;
  NoticeCommentController(this.commentRepository, this.id);

  // STATE
  bool _isLoading = true;
  bool _hasMore = false;
  int offset = 0;
  int limit = 20;

  // SERVER STATE
  List<NoticeCommentResponse> _rows = [];
  int _count = 0;

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  List<NoticeCommentResponse> get rows => _rows;
  int get count => _count;

  @override
  @mustCallSuper
  void onInit() async {
    super.onInit();
    await _fetchList(offset: offset, limit: limit);
  }

  // C
  Future<void> comment(int noticeId, String comment) async {
    const first = 0;

    try {
      final response = await commentRepository.comment(noticeId, comment.trim());
      _rows.insert(first, response);
      _count += 1;
      update();
    } catch (e) {
      _handleError(e);
    }
  }

  // R
  Future<void> moreComment() async {
    try {
      offset += limit;
      limit += limit;

      final response = await commentRepository.findAllByNoticeId(id, offset: offset, limit: limit);
      _rows.addAll(response.rows);
      _count = response.count;

      _hasMore = _rows.length < _count;
      update();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> refetch() async {
    await _fetchList();
  }

  // U
  Future<void> modifyComment(int id, int index, String comment) async {
    try {
      final response = await commentRepository.modify(id, comment.trim());
      _rows[index] = response;
      update();
    } catch (e) {
      _handleError(e);
    }
  }

  // D
  Future<void> deleteComment(int id, int index) async {
    try {
      await commentRepository.deleteById(id);
      await _fetchList();
      update();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _fetchList({int offset = 0, int limit = 20}) async {
    log('Hit $id notice comment list refetch');
    try {
      _isLoading == true ? _isLoading : true;
      update();

      final response = await commentRepository.findAllByNoticeId(id, offset: offset, limit: limit);
      _rows = response.rows;
      _count = response.count;
      _hasMore = _rows.length < _count;

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
