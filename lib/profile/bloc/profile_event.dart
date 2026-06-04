part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

final class GetProfileEvent extends ProfileEvent {
  const GetProfileEvent();
}

final class ShowProfileViewEvent extends ProfileEvent {
  const ShowProfileViewEvent();
}

final class ShowProfileUpdateViewEvent extends ProfileEvent {
  const ShowProfileUpdateViewEvent();
}

final class DeleteProfileEvent extends ProfileEvent {
  const DeleteProfileEvent();
}

final class ProfileFormChanged extends ProfileEvent {
  const ProfileFormChanged({
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
  });

  final String? email;
  final String? firstName;
  final String? lastName;
  final Gender? gender;

  @override
  List<Object?> get props => [
    email,
    firstName,
    lastName,
    gender,
  ];
}

final class UpdateProfileEvent extends ProfileEvent {
  const UpdateProfileEvent();
}