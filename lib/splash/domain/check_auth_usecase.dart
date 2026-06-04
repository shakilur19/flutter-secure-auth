import 'package:dartz/dartz.dart';
import '../../auth/data/authentication_repository.dart';

class CheckAuthUseCase {
  final AuthenticationRepository repository;

  CheckAuthUseCase(this.repository);

  Future<Either<bool, bool>> call() async {
    final isLoggedIn = await repository.isUserLoggedIn();
    return Right(isLoggedIn);
  }
}