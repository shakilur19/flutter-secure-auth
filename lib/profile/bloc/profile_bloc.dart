import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../utils/common_model/Email.dart';
import '../../utils/common_model/gender.dart';
import '../data/model/profile_fields.dart';
import '../data/model/profile_response.dart';
import '../data/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required ProfileRepository repository,
  })  : _repository = repository,
        super(ProfileState()) {
    on<GetProfileEvent>(_getProfile);
    on<ShowProfileViewEvent>(_showProfileView);
    on<ShowProfileUpdateViewEvent>(_showProfileUpdateView);
    on<ProfileFormChanged>(_onProfileFormChanged);
    on<UpdateProfileEvent>(_updateProfile);
    on<DeleteProfileEvent>(_deleteProfile);
  }

  final ProfileRepository _repository;

  Future<void> _getProfile(
      GetProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    emit(
      state.copyWith(
        profileStatus: FormzSubmissionStatus.inProgress,
        message: '',
      ),
    );

    final result = await _repository.getProfile();

    result.fold(
          (failure) {
        emit(
          state.copyWith(
            profileStatus: FormzSubmissionStatus.failure,
            message: failure.message,
          ),
        );
      },
          (profile) {
        emit(
          state.copyWith(
            profileStatus: FormzSubmissionStatus.success,
            profileResponse: profile,
            profileForm: _formFromProfile(profile),
            message: '',
          ),
        );
      },
    );
  }

  void _showProfileView(
      ShowProfileViewEvent event,
      Emitter<ProfileState> emit,
      ) {
    emit(
      state.copyWith(
        viewMode: ProfileViewMode.profile,
        updateProfileStatus: FormzSubmissionStatus.initial,
        message: '',
      ),
    );
  }

  void _showProfileUpdateView(
      ShowProfileUpdateViewEvent event,
      Emitter<ProfileState> emit,
      ) {
    emit(
      state.copyWith(
        viewMode: ProfileViewMode.updateProfile,
        profileForm: _formFromProfile(state.profileResponse),
        updateProfileStatus: FormzSubmissionStatus.initial,
        message: '',
      ),
    );
  }

  void _onProfileFormChanged(
      ProfileFormChanged event,
      Emitter<ProfileState> emit,
      ) {
    emit(
      state.copyWith(
        profileForm: state.profileForm.copyWith(
          email: event.email == null
              ? null
              : Email.dirty(event.email!),
          firstName: event.firstName,
          lastName: event.lastName,
          gender: event.gender,
        ),
        updateProfileStatus: FormzSubmissionStatus.initial,
        message: '',
      ),
    );
  }

  Future<void> _updateProfile(
      UpdateProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    final form = state.profileForm.copyWith(
      email: Email.dirty(state.profileForm.email.value),
    );

    emit(
      state.copyWith(
        profileForm: form,
        updateProfileStatus: FormzSubmissionStatus.initial,
        message: '',
      ),
    );

    if (!form.isValid) {
      emit(
        state.copyWith(
          updateProfileStatus: FormzSubmissionStatus.failure,
          message: 'Please fill all required fields',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        updateProfileStatus: FormzSubmissionStatus.inProgress,
        message: '',
      ),
    );

    final result = await _repository.updateProfile(form.toMap());

    result.fold(
          (failure) {
        emit(
          state.copyWith(
            updateProfileStatus: FormzSubmissionStatus.failure,
            message: failure.message,
          ),
        );
      },
          (data) {
        final profile = ProfileResponse.fromJson(data);

        emit(
          state.copyWith(
            profileResponse: profile,
            profileForm: _formFromProfile(profile),
            viewMode: ProfileViewMode.profile,
            updateProfileStatus: FormzSubmissionStatus.success,
            message: 'Profile updated successfully',
          ),
        );
      },
    );
  }

  ProfileFields _formFromProfile(ProfileResponse profile) {
    return ProfileFields(
      email: Email.dirty(profile.email ?? ''),
      firstName: profile.firstName ?? '',
      lastName: profile.lastName ?? '',
      gender: GenderX.fromApiValue(profile.gender),
    );
  }

  Future<void> _deleteProfile(
      DeleteProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    emit(
      state.copyWith(
        deleteProfileStatus: FormzSubmissionStatus.inProgress,
        message: '',
      ),
    );

    final result = await _repository.deleteProfile();

    result.fold(
          (failure) {
        emit(
          state.copyWith(
            deleteProfileStatus: FormzSubmissionStatus.failure,
            message: failure.message,
          ),
        );
      },
          (data) {
        emit(
          state.copyWith(
            deleteProfileStatus: FormzSubmissionStatus.success,
            message: data['message'] ?? 'Profile deleted successfully',
          ),
        );
      },
    );
  }
}