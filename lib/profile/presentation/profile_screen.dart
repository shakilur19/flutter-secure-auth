import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../utils/loading_view/loading_view.dart';
import '../../utils/navigation/navigation_service.dart';
import '../../utils/something_went_wrong.dart';
import '../bloc/profile_bloc.dart';
import 'widgets/profile_scaffold.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) =>
      previous.deleteProfileStatus != current.deleteProfileStatus,
      listener: (context, state) async {
        if (state.deleteProfileStatus.isSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.message.isNotEmpty
                      ? state.message
                      : 'Profile deleted successfully',
                ),
                duration: const Duration(seconds: 2),
              ),
            );

          await Future.delayed(const Duration(seconds: 2));

          if (!context.mounted) return;

          NavigationService.logoutAndNavigateToLoginScreen();
        }

        if (state.deleteProfileStatus.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.message.isNotEmpty
                      ? state.message
                      : 'Failed to delete profile',
                ),
              ),
            );
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.profileStatus.isInitial || state.profileStatus.isInProgress) {
            return const LoadingView();
          }

          if (state.profileStatus.isFailure) {
            return SomethingWentWrongPage(
              onRetry: () {
                context.read<ProfileBloc>().add(const GetProfileEvent());
              },
            );
          }

          return ProfileScaffold(state: state);
        },
      ),
    );
  }
}