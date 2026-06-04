part of 'signup_bloc.dart';

final class SignupState extends Equatable {
  const SignupState({
    this.status = FormzSubmissionStatus.initial,
    this.form = const SignupForm(),
    this.response,
    this.message = '',
  });

  final FormzSubmissionStatus status;
  final SignupForm form;
  final LoginResponse? response;
  final String message;

  bool get isValid => form.isValid;

  SignupState copyWith({
    FormzSubmissionStatus? status,
    SignupForm? form,
    LoginResponse? response,
    String? message,
  }) {
    return SignupState(
      status: status ?? this.status,
      form: form ?? this.form,
      response: response ?? this.response,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    status,
    form,
    response,
    message,
  ];
}