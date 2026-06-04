import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:equatable/equatable.dart';

final class BottomNavigationState extends Equatable{
  final int? index;

  const BottomNavigationState({
    this.index,
  });

  BottomNavigationState copyWith({
    int? index,
    CircularBottomNavigationController? navigationController,
  }) {
   return BottomNavigationState(
     index: index?? this.index,
   );
  }

  @override
  List<Object?> get props => [index];
}