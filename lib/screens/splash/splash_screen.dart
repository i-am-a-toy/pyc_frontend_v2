import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/get_route.dart';
import 'package:pyc/data/clients/client.dart';
import 'package:pyc/data/providers/auth/auth_provider.dart';
import 'package:pyc/data/repositories/auth/auth_repository.dart';
import 'package:pyc/screens/index/index_screen.dart';
import 'package:pyc/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// initState
  ///
  /// Splash Screen에서 FlutterSecureStorage에 있는 Token을 확인 후 해당 토큰의
  /// 토큰이 존재하고 검증에 통과할 경우 -> Index Screen
  /// 토큰이 존재하지 않거나 유효하지 않는 경우 -> Login Screen
  @override
  void initState() {
    super.initState();
    final repo = Get.put(AuthRepository(provider: AuthProvider(client: DioClient())));

    repo.validateMyToken().then((resp) {
      resp.isValid == true ? goToOffAllNamedWithDelay(IndexScreen.routeName) : goToOffAllNamedWithDelay(LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/passion_logo.png',
              width: size.width * 0.5,
              height: size.width * 0.5,
              color: kPrimaryColor,
            ),
            const Text(
              'Passion',
              style: TextStyle(
                fontSize: kDefaultValue * 2,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const Text(
              '열정 청년부',
              style: TextStyle(
                fontSize: kDefaultValue * 1.5,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
