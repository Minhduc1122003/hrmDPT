part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String no_;
  final String password;
  final String site;
  final apiToken;
  const LoginRequested(this.no_, this.password, this.site, this.apiToken);
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
