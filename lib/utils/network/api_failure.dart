import 'package:equatable/equatable.dart';
import 'api_exception.dart';
import 'cache_exception.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, this.statusCode});

  final dynamic message;
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class APIFailure extends Failure {
  const APIFailure({required super.message, required super.statusCode});
  APIFailure.fromException(APIException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
  CacheFailure.fromException(CacheException exception)
      : this(message: exception.message);
}