import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
    on<VerificationCodeSubmitted>(_onVerificationCodeSubmitted);
    on<PasswordResetRequested>(_onPasswordResetRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Implement actual login logic here
      await Future.delayed(Duration(seconds: 2)); // Simulating API call
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  void _onForgotPasswordRequested(ForgotPasswordRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Implement forgot password logic here
      await Future.delayed(Duration(seconds: 2)); // Simulating API call
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  void _onVerificationCodeSubmitted(VerificationCodeSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Implement verification code logic here
      await Future.delayed(Duration(seconds: 2)); // Simulating API call
      emit(VerificationCodeSuccess());
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  void _onPasswordResetRequested(PasswordResetRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Implement password reset logic here
      await Future.delayed(Duration(seconds: 2)); // Simulating API call
      emit(PasswordResetSuccess());
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
}