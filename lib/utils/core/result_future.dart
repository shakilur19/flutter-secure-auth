import 'package:dartz/dartz.dart';

import '../network/api_failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;