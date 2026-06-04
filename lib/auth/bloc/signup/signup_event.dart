part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

final class SignupEmailChanged extends SignupEvent {
  const SignupEmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

final class SignupPasswordChanged extends SignupEvent {
  const SignupPasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

final class SignupFirstNameChanged extends SignupEvent {
  const SignupFirstNameChanged(this.firstName);

  final String firstName;

  @override
  List<Object?> get props => [firstName];
}

final class SignupLastNameChanged extends SignupEvent {
  const SignupLastNameChanged(this.lastName);

  final String lastName;

  @override
  List<Object?> get props => [lastName];
}

final class SignupGenderChanged extends SignupEvent {
  const SignupGenderChanged(this.gender);

  final Gender gender;

  @override
  List<Object?> get props => [gender];
}

final class SignupSubmitted extends SignupEvent {
  const SignupSubmitted();
}