import 'package:equatable/equatable.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class PageTapped extends BottomNavigationEvent {
  final int index;

  const PageTapped({required this.index});

  @override
  List<Object> get props => [index];

  @override
  String toString() => 'PageTapped: $index';
}

