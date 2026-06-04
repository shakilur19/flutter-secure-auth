import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

import '../../../utils/common_model/Email.dart';
import '../../../utils/common_model/password.dart';
import '../../data/authentication_repository.dart';
import '../../model/login.dart';
import '../../model/login_response.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(LoginState()) {
    on<LoginEmailChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
      LoginEmailChanged event,
      Emitter<LoginState> emit,
      ) {
    final username = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: username,
        isValid: Formz.validate([state.password, username]),
      ),
    );
  }

  void _onPasswordChanged(
      LoginPasswordChanged event,
      Emitter<LoginState> emit,
      ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.email]),
      ),
    );
  }

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit,) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result = await _authenticationRepository.login(
          Login(email: state.email.value, password: state.password.value).toMap()
      );
      result.fold(
            (failure) {
          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
          ));
        },
            (data){
          emit(state.copyWith(
            response: LoginResponse.fromJson(data),
            status: FormzSubmissionStatus.success,
          ));
        },
      );
    }
  }
}