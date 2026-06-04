import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/check_auth_usecase.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckAuthUseCase checkAuthUseCase;

  SplashBloc(this.checkAuthUseCase) : super(SplashInitial()) {
    on<CheckAuthStatus>(_onCheckAuth);
  }

  Future<void> _onCheckAuth(CheckAuthStatus event, Emitter<SplashState> emit,
      ) async {
    emit(SplashLoading());

    final results = await Future.wait([
      checkAuthUseCase(),
      Future.delayed(const Duration(seconds: 3)),
    ]);

    final authResult = results[0];

    authResult.fold(
          (failure) => emit(SplashUnauthenticated()),
          (isLoggedIn) {
        if (isLoggedIn) {
          emit(SplashAuthenticated());
        } else {
          emit(SplashUnauthenticated());
        }
      },
    );
  }
}