import 'package:equatable/equatable.dart';
import '../../../utils/common_model/Email.dart';
import '../../../utils/common_model/gender.dart';
import '../../../utils/common_model/password.dart';

final class SignupForm extends Equatable {
  const SignupForm({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.firstName = '',
    this.lastName = '',
    this.gender = Gender.male,
  });

  final Email email;
  final Password password;
  final String firstName;
  final String lastName;
  final Gender gender;

  bool get isValid {
    return email.isValid &&
        password.isValid &&
        firstName.trim().isNotEmpty &&
        lastName.trim().isNotEmpty;
  }

  SignupForm copyWith({
    Email? email,
    Password? password,
    String? firstName,
    String? lastName,
    Gender? gender,
  }) {
    return SignupForm(
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
    );
  }

  Map<String, String> toMap() {
    return {
      'email': email.value.trim(),
      'password': password.value,
      'firstName': firstName.trim(),
      'lastName': lastName.trim(),
      'gender': gender.apiValue,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  @override
  List<Object?> get props => [
    email,
    password,
    firstName,
    lastName,
    gender,
  ];
}