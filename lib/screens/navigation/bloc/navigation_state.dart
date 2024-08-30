part of 'navigation_bloc.dart';

sealed class NavigationState extends Equatable {
  final int index;
  const NavigationState(this.index);

  @override
  List<Object> get props => [index];
}

class HomeState extends NavigationState {
  const HomeState() : super(0);
}

class PersonnelState extends NavigationState {
  const PersonnelState() : super(1);
}

class RecruitmentState extends NavigationState {
  const RecruitmentState() : super(2);
}

class DocumentsState extends NavigationState {
  const DocumentsState() : super(3);
}

class MeetingsState extends NavigationState {
  const MeetingsState() : super(4);
}
