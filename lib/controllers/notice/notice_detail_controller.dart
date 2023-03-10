import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/utils/get_snackbar.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/data/models/notice/responses/notice_response.dart';
import 'package:pyc/data/repositories/notice/notice_repository_interface.dart';

class NoticeDetailController extends GetxController {
  final INoticeRepository noticeRepository;
  final int id;
  NoticeDetailController(this.noticeRepository, this.id);

  //SERVER STATE
  NoticeResponse _notice = NoticeResponse.init();

  // STATE
  bool _isLoading = true;

  NoticeResponse get notice => _notice;
  bool get isLoading => _isLoading;

  @mustCallSuper
  @override
  void onInit() async {
    super.onInit();
    await _fetch();
  }

  Future<void> modify(int id, String title, String content) async {
    try {
      await noticeRepository.modify(id, title, content);
      await refetch();
      Get.back();
      showGetXSnackBar('알림', '공지사항이 수정되었습니다.');
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> deleteById() async {
    try {
      await noticeRepository.deleteById(id);
      Get.back();
      showGetXSnackBar('알림', '공지사항이 삭제되었습니다');
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> refetch() async {
    await _fetch();
  }

  Future<void> _fetch() async {
    try {
      log('Hit NoticeDetail with $id');
      _isLoading = true;
      update();

      _notice = await noticeRepository.findById(id);
      _isLoading = false;
      update();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  @mustCallSuper
  void onClose() async {
    super.onClose();
    log('NoticeDetail screen deleted & refetch notice list');
    await Get.find<NoticeController>().refetch();
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
