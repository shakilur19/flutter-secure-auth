import 'dart:async';
import 'package:dio/dio.dart';
import '../../auth/data/network/auth_datasource.dart';
import '../../auth/model/login_response.dart';
import '../cache/shared_preference.dart';
import '../common_model/token.dart';
import 'app_urls.dart';

class ApiProviderTokenInterceptor extends QueuedInterceptor {
  final AuthCacheDataSource authCacheDataSource;
  final Dio dioClient;

  bool _isRefreshing = false;
  final List<Completer<String?>> _refreshCompleters = [];

  ApiProviderTokenInterceptor({
    required this.authCacheDataSource,
    required this.dioClient,
  });

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    if (options.extra['isAuth'] == true) {
      final accessToken = await authCacheDataSource.getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        await cleanCache();
        return handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            message: 'Access token not found',
          ),
        );
      }

      if (options.extra['isFile'] == true) {
        options.headers.addAll({
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'multipart/form-data',
        });
      } else {
        options.headers.addAll({
          'Authorization': 'Bearer $accessToken',
        });
      }
    }

    handler.next(options);
  }

  @override
  void onResponse(
      Response<dynamic> response,
      ResponseInterceptorHandler handler,
      ) {
    handler.next(response);
  }

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    final options = err.requestOptions;

    final isUnauthorized = err.response?.statusCode == 401;
    final isAuthRequest = options.extra['isAuth'] == true;
    final alreadyRetried = options.extra['retried'] == true;

    if (!isUnauthorized || !isAuthRequest || alreadyRetried) {
      return handler.next(err);
    }

    try {
      final newAccessToken = await _getFreshAccessToken();

      if (newAccessToken == null || newAccessToken.isEmpty) {
        await cleanCache();
        return handler.reject(err);
      }

      options.headers['Authorization'] = 'Bearer $newAccessToken';
      options.extra['retried'] = true;

      final response = await _retryRequest(options);
      return handler.resolve(response);
    } catch (_) {
      await cleanCache();
      return handler.reject(err);
    }
  }

  Future<String?> _getFreshAccessToken() async {
    if (_isRefreshing) {
      final completer = Completer<String?>();
      _refreshCompleters.add(completer);
      return completer.future;
    }

    _isRefreshing = true;

    try {
      final newAccessToken = await refreshToken();

      for (final completer in _refreshCompleters) {
        completer.complete(newAccessToken);
      }

      _refreshCompleters.clear();
      return newAccessToken;
    } catch (_) {
      for (final completer in _refreshCompleters) {
        completer.complete(null);
      }

      _refreshCompleters.clear();
      return null;
    } finally {
      _isRefreshing = false;
    }
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions options) async {
    return dioClient.request<dynamic>(
      options.path,
      queryParameters: options.queryParameters,
      data: options.data,
      options: Options(
        method: options.method,
        headers: options.headers,
        responseType: options.responseType,
        contentType: options.contentType,
        extra: options.extra,
      ),
    );
  }

  Future<String?> refreshToken() async {
    final refreshToken = await authCacheDataSource.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    final dio = Dio();

    final response = await dio.post(
      AppUrls.refreshTokenUrl(),
      data: {
        'refreshToken': refreshToken,
      },
    );

    if (response.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(response.data);

      final token = Token(
        accessToken: loginResponse.accessToken,
        refreshToken: loginResponse.refreshToken,
      );

      await authCacheDataSource.saveToken(token);

      return token.accessToken;
    }

    return null;
  }

  Future<void> cleanCache() async {
    await SharedPreference.removeAll();
  }
}