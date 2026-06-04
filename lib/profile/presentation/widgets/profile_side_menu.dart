import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/common_color.dart';
import '../../../utils/dialogue/common_dialogue.dart';
import '../../../utils/navigation/navigation_service.dart';
import '../../bloc/profile_bloc.dart';
import 'profile_menu_item.dart';

class ProfileSideMenu extends StatelessWidget {
  const ProfileSideMenu({
    super.key,
    required this.onClose,
  });

  final VoidCallback onClose;

  void _showProfile(BuildContext context) {
    context.read<ProfileBloc>().add(const ShowProfileViewEvent());
    onClose();
  }

  void _showUpdateProfile(BuildContext context) {
    context.read<ProfileBloc>().add(const ShowProfileUpdateViewEvent());
    onClose();
  }

  void _deleteProfile(BuildContext context) {
    context.read<ProfileBloc>().add(const DeleteProfileEvent());
    onClose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      child: SizedBox(
        width: 260,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: CommonColor.appBarColor(),
                child: const Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ProfileMenuItem(
                icon: Icons.person,
                title: 'Profile',
                onTap: () => _showProfile(context),
              ),
              ProfileMenuItem(
                icon: Icons.edit,
                title: 'Update Profile',
                onTap: () => _showUpdateProfile(context),
              ),
              ProfileMenuItem(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {
                  CommonConfirmDialog.show(
                    context: context,
                    title: 'Logout',
                    message: 'Are you sure you want to logout?',
                    yesText: 'Logout',
                    noText: 'Cancel',
                    onYes: () {
                      NavigationService.logoutAndNavigateToLoginScreen();
                    },
                  );
                },
              ),
              ProfileMenuItem(
                icon: Icons.delete,
                title: 'Delete Profile',
                isDanger: true,
                onTap: () {
                  CommonConfirmDialog.show(
                    context: context,
                    title: 'Delete Profile',
                    message: 'Are you sure you want to delete your profile?',
                    yesText: 'Delete',
                    noText: 'Cancel',
                    isDanger: true,
                    onYes: () => _deleteProfile(context),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}