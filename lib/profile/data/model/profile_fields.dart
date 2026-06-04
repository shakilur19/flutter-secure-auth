import '../../../utils/common_model/Email.dart';
import '../../../utils/common_model/gender.dart';
import 'package:equatable/equatable.dart';

final class ProfileFields extends Equatable {
  const ProfileFields({
    this.email = const Email.pure(),
    this.firstName = '',
    this.lastName = '',
    this.gender = Gender.male,
  });

  final Email email;
  final String firstName;
  final String lastName;
  final Gender gender;

  bool get isValid {
    return email.isValid &&
        firstName.trim().isNotEmpty &&
        lastName.trim().isNotEmpty;
  }

  ProfileFields copyWith({
    Email? email,
    String? firstName,
    String? lastName,
    Gender? gender,
  }) {
    return ProfileFields(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
    );
  }

  Map<String, String> toMap() {
    return {
      'email': email.value.trim(),
      'firstName': firstName.trim(),
      'lastName': lastName.trim(),
      'gender': gender.apiValue,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  @override
  List<Object?> get props => [
    email,
    firstName,
    lastName,
    gender,
  ];
}