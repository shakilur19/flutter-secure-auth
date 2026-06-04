import 'package:flutter/material.dart';
import '../../data/model/profile_response.dart';
import 'profile_field.dart';


class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.profile,
  });

  final ProfileResponse profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 58,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 53,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          color: Colors.white,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ProfileField(
                  label: 'First Name',
                  value: profile.firstName ?? 'No name',
                ),
                const SizedBox(height: 16),
                ProfileField(
                  label: 'Last Name',
                  value: profile.lastName ?? 'No name',
                ),
                const SizedBox(height: 16),
                ProfileField(
                  label: 'Email',
                  value: profile.email ?? 'No email',
                ),
                const SizedBox(height: 16),
                ProfileField(
                  label: 'Gender',
                  value: profile.gender ?? 'No gender',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}