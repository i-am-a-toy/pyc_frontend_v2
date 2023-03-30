import 'package:get/get.dart';
import 'package:pyc/binding/calendar_binding.dart';
import 'package:pyc/binding/index_binding.dart';
import 'package:pyc/binding/login_binding.dart';
import 'package:pyc/binding/notice_detail_binding.dart';
import 'package:pyc/screens/calendar/calendar_screen.dart';
import 'package:pyc/screens/index/index_screen.dart';
import 'package:pyc/screens/login/login_screen.dart';
import 'package:pyc/screens/notice/notice_comment_modify_screen.dart';
import 'package:pyc/screens/notice/notice_detail_screen.dart';
import 'package:pyc/screens/notice/notice_modify_screen.dart';
import 'package:pyc/screens/notice/notice_screen.dart';
import 'package:pyc/screens/notice/notice_write_screen.dart';
import 'package:pyc/screens/splash/splash_screen.dart';

List<GetPage> routes = [
  // Splash Screen
  GetPage(
    name: SplashScreen.routeName,
    page: () => const SplashScreen(),
  ),
  // Login Screen
  GetPage(
    name: LoginScreen.routeName,
    page: () => const LoginScreen(),
    binding: LoginBinding(),
  ),
  // Index Screen
  GetPage(
    name: IndexScreen.routeName,
    page: () => const IndexScreen(),
    binding: IndexBinding(),
  ),
  // Calendar Screen
  ...[
    GetPage(
      name: CalendarScreen.routeName,
      page: () => const CalendarScreen(),
      binding: CalendarBinding(),
    ),
  ],
  // Notice Screen
  ...[
    GetPage(
      name: NoticeScreen.routeName,
      page: () => const NoticeScreen(),
    ),
    GetPage(
      name: NoticeWriteScreen.routeName,
      page: () => const NoticeWriteScreen(),
    ),
    GetPage(
      name: NoticeModifyScreen.routeName,
      page: () => const NoticeModifyScreen(),
    ),
    GetPage(
      name: NoticeDetailScreen.routeName,
      page: () => const NoticeDetailScreen(),
      binding: NoticeDetailBinding(),
    ),
    GetPage(
      name: NoticeCommentModifyScreen.routeName,
      page: () => const NoticeCommentModifyScreen(),
    )
  ]
];
