import 'dart:developer';

import 'package:get/get.dart';

class NoticeMiddleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    log('123');
    return page;
  }
}
