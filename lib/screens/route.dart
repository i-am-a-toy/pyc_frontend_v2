import 'package:get/get.dart';
import 'package:pyc/binding/index_binding.dart';
import 'package:pyc/binding/login_binding.dart';
import 'package:pyc/screens/index/index_screen.dart';
import 'package:pyc/screens/login/login_screen.dart';
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
];
