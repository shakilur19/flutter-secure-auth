import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'api_failure.dart';

enum HTTPType { get, post, put, delete, patch, download }

class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Future<Either<APIFailure, dynamic>> invokeApi(
      String path,
      HTTPType method, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParams,
        bool isAuth = false,
        bool isFile = false,
        bool isXApi = false,
        bool isPaymentXApi = false,
      }) async {
    try {
      final response = await _dio.request<dynamic>(
        path,
        data: isFile && data != null ? FormData.fromMap(data) : data,
        queryParameters: queryParams,
        options: Options(
          method: method.name.toUpperCase(),
          extra: {
            'isAuth': isAuth,
            'isFile': isFile,
            'isXApi': isXApi,
            'isPaymentXApi': isPaymentXApi,
          },
        ),
      );

      return Right(response.data);
    } on DioException catch (error) {
      return Left(_mapDioError(error));
    } catch (_) {
      return const Left(
        APIFailure(
          message: 'Something went wrong',
          statusCode: 500,
        ),
      );
    }
  }

  Future<Response<dynamic>> fetch(RequestOptions options) {
    return _dio.fetch<dynamic>(options);
  }

  APIFailure _mapDioError(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;

    if (response != null) {
      return APIFailure(
        message: _extractMessage(response.data),
        statusCode: statusCode ?? 400,
      );
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const APIFailure(
          message: 'Request timeout',
          statusCode: 600,
        );

      case DioExceptionType.connectionError:
        return const APIFailure(
          message: 'No internet connection',
          statusCode: 800,
        );

      case DioExceptionType.cancel:
        return const APIFailure(
          message: 'Request cancelled',
          statusCode: 700,
        );

      case DioExceptionType.badCertificate:
        return const APIFailure(
          message: 'Bad certificate',
          statusCode: 900,
        );

      case DioExceptionType.badResponse:
        return APIFailure(
          message: _extractMessage(error.response?.data),
          statusCode: error.response?.statusCode ?? 400,
        );

      case DioExceptionType.unknown:
        return APIFailure(
          message: error.message ?? 'Unknown error',
          statusCode: 600,
        );
    }
  }

  String _extractMessage(dynamic data) {
    if (data == null) return 'Something went wrong';

    if (data is Map<String, dynamic>) {
      final message = data['message'];

      if (message is String && message.trim().isNotEmpty) {
        return message;
      }

      if (message is List && message.isNotEmpty) {
        return message.join(', ');
      }

      final error = data['error'];

      if (error is String && error.trim().isNotEmpty) {
        return error;
      }
    }

    if (data is String && data.trim().isNotEmpty) {
      return data;
    }

    return 'Something went wrong';
  }
}