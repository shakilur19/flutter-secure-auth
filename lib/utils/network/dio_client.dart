import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../auth/data/network/auth_datasource.dart';
import '../../auth/data/network/auth_datasource_impl.dart';
import '../cache/cache.dart';
import 'app_urls.dart';
import 'token_interceptor.dart';

class DioClient {
  static final _dioClient = DioClient._internal();

  DioClient._internal();
  late AuthCacheDataSource authCacheDataSource;

  Dio dio = Dio(
    BaseOptions(
      baseUrl: AppUrls.getBaseUrl(),
      connectTimeout: const Duration(minutes: 10),
      sendTimeout: const Duration(minutes: 5),
      receiveTimeout: const Duration(minutes: 5),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    ),
  );

  factory DioClient() {
    return _dioClient;
  }

  void setClient() {
    authCacheDataSource = AuthCacheDataSourceImpl(Cache());
    dio
      ..interceptors.add(ApiProviderTokenInterceptor(dioClient: dio, authCacheDataSource: authCacheDataSource))
      ..interceptors.add(PrettyDioLogger(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        error: true,
      ));
  }

  Dio getClient() {
    return dio;
  }
}

final DioClient dioClient = DioClient();