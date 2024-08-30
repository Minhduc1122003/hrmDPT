part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class ForgotPasswordRequested extends AuthEvent {
  final String email;

  const ForgotPasswordRequested({required this.email});

  @override
  List<Object> get props => [email];
}

class VerificationCodeSubmitted extends AuthEvent {
  final String code;

  const VerificationCodeSubmitted({required this.code});

  @override
  List<Object> get props => [code];
}

class PasswordResetRequested extends AuthEvent {
  final String newPassword;

  const PasswordResetRequested({required this.newPassword});

  @override
  List<Object> get props => [newPassword];
}
