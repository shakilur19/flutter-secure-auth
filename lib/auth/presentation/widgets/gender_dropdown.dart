import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/common_model/gender.dart';
import '../../bloc/signup/signup_bloc.dart';

class GenderDropdown extends StatelessWidget {
  const GenderDropdown({super.key,
    required this.value,
  });

  final Gender value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Gender>(
      value: value,
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
      onChanged: (value) {
        if (value == null) return;

        context.read<SignupBloc>().add(
          SignupGenderChanged(value),
        );
      },
    );
  }
}