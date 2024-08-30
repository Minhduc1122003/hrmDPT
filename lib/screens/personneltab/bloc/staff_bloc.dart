import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  StaffBloc() : super(StaffInitial()) {
    on<StaffEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
