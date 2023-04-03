import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response;
import 'package:pyc/common/utils/get_snackbar.dart';
import 'package:pyc/data/clients/client_interface.dart';
import 'package:pyc/data/models/auth/requests/refresh_request.dart';
import 'package:pyc/data/models/auth/responses/token_response.dart';
import 'package:pyc/screens/login/login_screen.dart';

class DioClient extends GetxService implements IClient<Dio> {
  @override
  Dio getClient() {
    return _getDefaultClient();
  }

  @override
  Future<Dio> getAuthClient() async {
    final dio = _getDefaultClient();

    /// interceptor clear & define request & error interceptor
    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(onRequest: _originOnRequest(), onError: _originErrorCallBack(dio)));
    return dio;
  }

  /// _originOnRequest
  ///
  /// description: FlutterSecureStorage에 AccessToken이 존재한지 확인 후 존재한다면 원본 요청을 그대로 요청한다.
  /// 만일 토큰이 존재하지 않는다면 snackbar와 함께 로그인 페이지로 이동한다.
  InterceptorSendCallback _originOnRequest() {
    return (options, handler) {
      const storage = FlutterSecureStorage();
      storage.read(key: 'token').then((token) {
        if (token == null) {
          log('AccessToken not exist & Go login screen');
          Get.offAllNamed(LoginScreen.routeName);
          showGetXSnackBar('알림', '인증정보가 존재하지 않아 로그인 페이지로 이동합니다.');
          return;
        }

        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      });
    };
  }

  /// _originErrorCallBack
  ///
  /// description: 서버에 Token과 함께 요청을 보냈을 때 인증에 실패한 경우 401 Status를 받게 된다.
  /// FlutterSecureStorage에 Token과 Refresh가 존재한다면 Refresh 요청 후 origin request를 다시 요청한다.
  /// Refresh 요청이 실패하게 된다면 Response StatusCode에 따라 예외를 처리한다.
  /// 만일 Token과 Refresh 둘 중 하나가 존재하지 않는다면 snackbar와 함께 로그인 페이지로 이동한다.
  InterceptorErrorCallback _originErrorCallBack(Dio dio) {
    return (e, handler) async {
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        log('Try refresh request');

        /// validate exist refresh
        const storage = FlutterSecureStorage();
        final String? token = await storage.read(key: 'token');
        final String? refresh = await storage.read(key: 'refresh');
        if (token == null || refresh == null) {
          log('Refresh token not exist');
          Get.offAllNamed(LoginScreen.routeName);
          showGetXSnackBar('알림', '인증정보가 존재하지 않아 로그인 페이지로 이동합니다.');
          return;
        }

        // try Refresh
        try {
          final resp = await _refresh(token, refresh);

          await storage.deleteAll();
          await storage.write(key: 'token', value: resp.accessToken);
          await storage.write(key: 'refresh', value: resp.refreshToken);
        } catch (e) {
          log('Refresh token  error: ${(e as DioError).response?.data}');
          _handleRefreshAuthError(e.response?.statusCode ?? HttpStatus.internalServerError);
        }

        //reTry origin request
        log('Success refresh & Try original request');
        final newToken = await storage.read(key: 'token');
        final response = await _reTryOriginRequest(dio, e.requestOptions, newToken!);
        return handler.resolve(response);
      } else {
        return handler.next(e);
      }
    };
  }

  Future<TokenResponse> _refresh(String token, String refresh) async {
    final resp = await _getDefaultClient().put('/auth/refresh', data: RefreshRequest(token, refresh).toJSON());
    return TokenResponse.fromJSON(resp.data);
  }

  Future<Response> _reTryOriginRequest(Dio dio, RequestOptions options, String token) async {
    options.headers.update('Authorization', (value) => 'Bearer $token');
    return dio.request(
      options.path,
      options: Options(
        method: options.method,
        headers: options.headers,
      ),
      data: options.data,
      queryParameters: options.queryParameters,
    );
  }

  void _handleRefreshAuthError(int statusCode) {
    switch (statusCode) {
      case HttpStatus.badRequest:
        Get.offAllNamed(LoginScreen.routeName);
        showGetXSnackBar('알림', '인증 정보가 유효하지 않아 로그인 페이지로 이동합니다.');
        return;
      case HttpStatus.notFound:
        Get.offAllNamed(LoginScreen.routeName);
        showGetXSnackBar('알림', '재 인증정보가 존재하지 않아 로그인 페이지로 이동합니다.');
        return;
      case HttpStatus.methodNotAllowed:
        Get.offAllNamed(LoginScreen.routeName);
        showGetXSnackBar('알림', '재 인증정보가 만료되어 로그인 페이지로 이동합니다.');
        return;
      default:
        Get.offAllNamed(LoginScreen.routeName);
        showGetXSnackBar('알림', '인증 정보가 유효하지 않아 로그인 페이지로 이동합니다.');
    }
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
