part of 'staff_bloc.dart';

sealed class StaffState extends Equatable {
  const StaffState();
  
  @override
  List<Object> get props => [];
}

final class StaffInitial extends StaffState {}
