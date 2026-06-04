part of 'profile_bloc.dart';

enum ProfileViewMode {
  profile,
  updateProfile,
}

final class ProfileState extends Equatable {
  ProfileState({
    this.profileStatus = FormzSubmissionStatus.initial,
    this.updateProfileStatus = FormzSubmissionStatus.initial,
    this.deleteProfileStatus = FormzSubmissionStatus.initial,
    this.viewMode = ProfileViewMode.profile,
    ProfileResponse? profileResponse,
    ProfileFields? profileForm,
    this.message = '',
  })  : profileResponse = profileResponse ?? ProfileResponse(),
        profileForm = profileForm ?? const ProfileFields();

  final FormzSubmissionStatus profileStatus;
  final FormzSubmissionStatus updateProfileStatus;
  final FormzSubmissionStatus deleteProfileStatus;
  final ProfileViewMode viewMode;
  final ProfileResponse profileResponse;
  final ProfileFields profileForm;
  final String message;

  bool get isUpdateFormValid => profileForm.isValid;

  ProfileState copyWith({
    FormzSubmissionStatus? profileStatus,
    FormzSubmissionStatus? updateProfileStatus,
    FormzSubmissionStatus? deleteProfileStatus,
    ProfileViewMode? viewMode,
    ProfileResponse? profileResponse,
    ProfileFields? profileForm,
    String? message,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus,
      deleteProfileStatus: deleteProfileStatus ?? this.deleteProfileStatus,
      viewMode: viewMode ?? this.viewMode,
      profileResponse: profileResponse ?? this.profileResponse,
      profileForm: profileForm ?? this.profileForm,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    profileStatus,
    updateProfileStatus,
    deleteProfileStatus,
    viewMode,
    profileResponse,
    profileForm,
    message,
  ];
}