part of 'navigation_bloc.dart';

sealed class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigationTabChanged extends NavigationEvent {
  final int index;
  const NavigationTabChanged(this.index);

  @override
  List<Object> get props => [index];
}