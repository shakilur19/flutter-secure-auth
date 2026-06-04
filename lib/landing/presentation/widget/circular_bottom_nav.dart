import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/common_color.dart';
import '../../bloc/bottom_nav/bottom_nav_bloc.dart';
import '../../bloc/bottom_nav/bottom_nav_event.dart';
import '../../bloc/bottom_nav/bottom_nav_state.dart';

class CircularBottomNavigationBarView extends StatefulWidget {
  final List<TabItem> items;

  const CircularBottomNavigationBarView({super.key, required this.items});

  @override
  CircularBottomNavigationBarViewState createState() => CircularBottomNavigationBarViewState();
}

class CircularBottomNavigationBarViewState
    extends State<CircularBottomNavigationBarView> {
  late CircularBottomNavigationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CircularBottomNavigationController(0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        if (state.index != _controller.value) {
          _controller.value = state.index!;
        }

        return CircularBottomNavigation(
          widget.items,
          controller: _controller,
          barHeight: 60,
          barBackgroundColor: CommonColor.appBarColor(),
          normalIconColor: CommonColor.bottomNavIconColor(),
          selectedIconColor: CommonColor.bottomNavSelectedIconColor(),
          backgroundBoxShadow: const <BoxShadow>[
            BoxShadow(color: Colors.black45, blurRadius: 10.0),
          ],
          animationDuration: const Duration(milliseconds: 300),
          selectedCallback: (int? selectedPos) {
            if (selectedPos != null) {
              context.read<BottomNavigationBloc>().add(PageTapped(index: selectedPos));
            }
          },
        );
      },
    );
  }
}
