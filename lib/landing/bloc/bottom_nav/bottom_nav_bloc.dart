import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_nav_event.dart';
import 'bottom_nav_state.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationState(index: 0)) {
    on<PageTapped>(_onPageTapped);
  }

  void _onPageTapped(PageTapped event, Emitter<BottomNavigationState> emit) {
    emit(state.copyWith(index: event.index, navigationController: CircularBottomNavigationController(event.index)));
  }
}
