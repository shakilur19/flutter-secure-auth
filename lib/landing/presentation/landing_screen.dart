import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../utils/loading_view/loading_view.dart';
import '../bloc/landing/bloc.dart';
import '../bloc/landing/event.dart';
import '../bloc/landing/state.dart';
import 'widget/body_view.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();

    context.read<LandingBloc>().add(GetLandingNavigationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingBloc, LandingState>(
      builder: (context, state) {
        if (state.status.isInProgress || !state.status.isSuccess) {
          return const LoadingView();
        }

        return Scaffold(
          body: BodyView(),
        );
      },
    );
  }
}