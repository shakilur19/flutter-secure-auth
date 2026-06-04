import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../utils/common_model/Email.dart';
import '../../../utils/common_model/password.dart';
import '../../data/authentication_repository.dart';
import '../../data/models/signup_form.dart';
import '../../model/login_response.dart';
import '../../../utils/common_model/gender.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(SignupState()) {
    on<SignupEmailChanged>(_onEmailChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupFirstNameChanged>(_onFirstNameChanged);
    on<SignupLastNameChanged>(_onLastNameChanged);
    on<SignupGenderChanged>(_onGenderChanged);
    on<SignupSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onEmailChanged(
      SignupEmailChanged event,
      Emitter<SignupState> emit,
      ) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          email: Email.dirty(event.email),
        ),
      ),
    );
  }

  void _onPasswordChanged(
      SignupPasswordChanged event,
      Emitter<SignupState> emit,
      ) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          password: Password.dirty(event.password),
        ),
      ),
    );
  }

  void _onFirstNameChanged(
      SignupFirstNameChanged event,
      Emitter<SignupState> emit,
      ) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          firstName: event.firstName,
        ),
      ),
    );
  }

  void _onLastNameChanged(
      SignupLastNameChanged event,
      Emitter<SignupState> emit,
      ) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          lastName: event.lastName,
        ),
      ),
    );
  }

  void _onGenderChanged(
      SignupGenderChanged event,
      Emitter<SignupState> emit,
      ) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          gender: event.gender,
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
      SignupSubmitted event,
      Emitter<SignupState> emit,
      ) async {
    final form = state.form.copyWith(
      email: Email.dirty(state.form.email.value),
      password: Password.dirty(state.form.password.value),
    );

    emit(
      state.copyWith(
        form: form,
        status: FormzSubmissionStatus.initial,
        message: '',
      ),
    );

    if (!form.isValid) return;

    emit(
      state.copyWith(
        status: FormzSubmissionStatus.inProgress,
        message: '',
      ),
    );

    final result = await _authenticationRepository.signup(form.toMap());

    result.fold(
          (failure) {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            message: failure.message,
          ),
        );
      },
          (response) {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.success,
            message: response['message'] ?? 'Signup successful',
          ),
        );
      },
    );
  }
}