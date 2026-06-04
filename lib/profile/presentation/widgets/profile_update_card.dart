import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../utils/common_model/gender.dart';
import '../../bloc/profile_bloc.dart';

class ProfileUpdateCard extends StatelessWidget {
  const ProfileUpdateCard({
    super.key,
    required this.state,
  });

  final ProfileState state;

  @override
  Widget build(BuildContext context) {
    final form = state.profileForm;
    final isLoading = state.updateProfileStatus.isInProgress;

    return Card(
      elevation: 8,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Update Profile',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),

            _ProfileInput(
              label: 'First Name',
              initialValue: form.firstName,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                context.read<ProfileBloc>().add(
                  ProfileFormChanged(firstName: value),
                );
              },
            ),
            const SizedBox(height: 14),

            _ProfileInput(
              label: 'Last Name',
              initialValue: form.lastName,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                context.read<ProfileBloc>().add(
                  ProfileFormChanged(lastName: value),
                );
              },
            ),
            const SizedBox(height: 14),

            DropdownButtonFormField<Gender>(
              value: form.gender,
              decoration: const InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
              items: Gender.values.map((gender) {
                return DropdownMenuItem<Gender>(
                  value: gender,
                  child: Text(gender.apiValue),
                );
              }).toList(),
              onChanged: isLoading
                  ? null
                  : (value) {
                if (value == null) return;

                context.read<ProfileBloc>().add(
                  ProfileFormChanged(gender: value),
                );
              },
            ),
            const SizedBox(height: 24),

            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                  context.read<ProfileBloc>().add(
                    const UpdateProfileEvent(),
                  );
                },
                child: isLoading
                    ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : const Text('Update Profile'),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 48,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: isLoading
                    ? null
                    : () {
                  context.read<ProfileBloc>().add(
                    const ShowProfileViewEvent(),
                  );
                },
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileInput extends StatelessWidget {
  const _ProfileInput({
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.textInputAction,
  });

  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}