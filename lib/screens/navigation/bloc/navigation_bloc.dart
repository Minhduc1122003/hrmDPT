import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const HomeState()) {
    on<NavigationTabChanged>((event, emit) {
      switch (event.index) {
        case 0:
          emit(const HomeState());
          break;
        case 1:
          emit(const PersonnelState());
          break;
        case 2:
          emit(const RecruitmentState());
          break;
        case 3:
          emit(const DocumentsState());
          break;
        case 4:
          emit(const MeetingsState());
          break;
        default:
          emit(const HomeState());
      }
    });
  }
}
