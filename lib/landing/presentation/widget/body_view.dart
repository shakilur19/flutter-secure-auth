import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_template/profile/presentation/profile_screen.dart';
import '../../../utils/common_font_style.dart';
import '../../bloc/bottom_nav/bottom_nav_bloc.dart';
import '../../bloc/bottom_nav/bottom_nav_state.dart';
import 'circular_bottom_nav.dart';
import 'profile_view.dart';

class BodyView extends StatelessWidget{

  BodyView({super.key});

  List<TabItem> tabItems = List.of([
    TabItem(
      Icons.home,
      "Home",
      Colors.white,
      circleStrokeColor: Colors.white,
      labelStyle: CommonFontStyle.boldFontStyle(fontSize: 12, color: Colors.white),
    ),
    TabItem(
      Icons.subscriptions,
      "Summary",
      Colors.white,
      circleStrokeColor: Colors.white,
      labelStyle: CommonFontStyle.boldFontStyle(fontSize: 12, color: Colors.white),
    ),
    TabItem(
      Icons.layers,
      "Demo",
      Colors.white,
      circleStrokeColor: Colors.white,
      labelStyle: CommonFontStyle.boldFontStyle(fontSize: 12, color: Colors.white)
    ),
    TabItem(
      Icons.person,
      "Profile",
      Colors.white,
      circleStrokeColor: Colors.white,
      labelStyle: CommonFontStyle.boldFontStyle(fontSize: 12, color: Colors.white),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
            builder: (BuildContext context, BottomNavigationState state) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: getItem(state),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: CircularBottomNavigationBarView(items: tabItems),
        )
      ],
    );
  }

  Widget getItem(BottomNavigationState state) {
    switch(state.index) {
      case 0:
        return Center(child: Text("Welcome"),);
      case 1:
        return Container();
      case 2:
        return const Center(child: Text("Demo page"));
      case 3:
        return const ProfileWidget();
      default: return Container();
    }
  }
}