import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../../../utils/common_model/Email.dart';
import '../../../utils/common_model/password.dart';
import '../../model/login_response.dart';

final class LoginState extends Equatable {

  LoginState({
    this.status = FormzSubmissionStatus.initial,
    LoginResponse? response,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
  }): response = response ?? LoginResponse();

  final LoginResponse response;
  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final bool isValid;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    LoginResponse? response,
    Email? email,
    Password? password,
    bool? isValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      response: response?? this.response,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, response, email, password, isValid];
}