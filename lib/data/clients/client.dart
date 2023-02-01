import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:pyc/common/utils/get_snackbar.dart';
import 'package:pyc/data/clients/client_interface.dart';
import 'package:pyc/data/models/auth/requests/refresh_request.dart';
import 'package:pyc/data/models/auth/responses/token_request.dart';
import 'package:pyc/screens/login/login_screen.dart';

class DioClient extends GetxService implements IClient<Dio> {
  /// getClient
  ///
  /// description: 인증이 필요없는 Http Client
  @override
  Dio getClient() {
    return _getDefaultClient();
  }

  /// getAuthClient
  ///
  /// description: FlutterSecureStorage에서 Token을 얻어와 Token과 함께 Request를 보내는 HttpRequest
  /// 만약 토큰이 존재하지 않거나 Refresh 요청에 실패한다면 Route 전부를 제거하고 Login 페이지로 이동시킨다.
  /// 작업 진행순서는 아래와 같다.
  /// 1. FlutterSecureStorage에서 AccessToken을 가지고 요청을 보낸다.
  /// 2. 인증에 실패하면 Refresh Token이 있는지 확인 후 Refresh를 요청한다.
  /// 3. 성공시 FlutterSecureStorage에 다시 Token을 write한 후 원본 요청을 다시 보내게 된다.
  @override
  Future<Dio> getAuthClient() async {
    final dio = _getDefaultClient();
    const storage = FlutterSecureStorage();

    //token Validate
    final token = await storage.read(key: 'token');
    if (token == null || token == '') {
      log('Token not Exist');
      Get.offAllNamed(LoginScreen.routeName);
    }

    //interceptors Clear & validate interceptors
    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        /// Origin Request
        onRequest: ((options, handler) async {
          options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        }),

        /// Try Refresh Request & Error Handing
        onError: ((e, handler) async {
          if (e.response?.statusCode != HttpStatus.internalServerError) {
            final refreshToken = await storage.read(key: 'refresh');
            if (refreshToken == null || refreshToken == '') {
              log('refresh Token not Exist');
              Get.offAllNamed(LoginScreen.routeName);
            }

            /// Try Refresh
            final refreshDio = _getDefaultClient();
            refreshDio.interceptors.clear();
            refreshDio.interceptors.add(
              InterceptorsWrapper(
                onError: (e, handler) async {
                  if (e.response?.statusCode != HttpStatus.ok && e.response?.statusCode != HttpStatus.internalServerError) {
                    log('refresh Token is expired');
                    Get.offAllNamed(LoginScreen.routeName);
                    showGetSnackBar('알림', '인증이 만료되어 로그인페이지로 이동합니다.');
                    return;
                  }

                  log('Fail refresh request with Error: ${e.response?.data}');
                  Get.offAllNamed(LoginScreen.routeName);
                  showGetSnackBar('알림', '서버에 이상이 있습니다. 관리자에게 문의해주세요.');
                },
              ),
            );
            final res = await refreshDio.put('/auth/refresh', data: RefreshRequest(token!, refreshToken!).toJSON());
            final tokenResponse = TokenResponse.fromJSON(res.data);

            /// Rewrite AccessToken & RefreshToken
            await storage.write(key: 'token', value: tokenResponse.accessToken);
            await storage.write(key: 'refresh', value: tokenResponse.refreshToken);

            /// Retry Origin Request
            e.requestOptions.headers['Authorization'] = 'Bearer ${tokenResponse.accessToken}';
            final retryRequest = await dio.request(
              e.requestOptions.path,
              options: Options(
                method: e.requestOptions.method,
                headers: e.requestOptions.headers,
              ),
              data: e.requestOptions.data,
              queryParameters: e.requestOptions.queryParameters,
            );
            return handler.resolve(retryRequest);
          }

          /// 여기서 던져지는 Error는 각 Provider에서 Handing할 것
          log('Fail request with Error: ${e.response?.data}');
          return handler.next(e);
        }),
      ),
    );

    return dio;
  }

  Dio _getDefaultClient() {
    return Dio(
      BaseOptions(
        maxRedirects: 1,
        connectTimeout: 2000,
        baseUrl: dotenv.get('BASE_URL', fallback: 'http://localhost:3000'),
      ),
    );
  }
}
