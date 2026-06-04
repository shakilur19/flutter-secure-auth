import 'package:flutter/material.dart';

import '../../../utils/common_color.dart';
import '../../bloc/profile_bloc.dart';
import 'profile_card.dart';
import 'profile_update_card.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
    required this.state,
  });

  final ProfileState state;

  @override
  Widget build(BuildContext context) {
    final child = switch (state.viewMode) {
      ProfileViewMode.profile => ProfileCard(profile: state.profileResponse),
      ProfileViewMode.updateProfile => ProfileUpdateCard(state: state),
    };

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CommonColor.bottomNavIconColor(),
            CommonColor.appBarColor(),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}