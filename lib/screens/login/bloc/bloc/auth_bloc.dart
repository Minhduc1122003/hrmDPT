import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hrm/model/login_model.dart';
import 'package:hrm/network/api_provider.dart';
import 'package:crypto/crypto.dart';

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
    print('email: ${event.no_}');
    print('password: ${event.password}');
    String newPassword = convertPassword(event.password);
    print(newPassword);
    print('site: ${event.site}');
    print('apiToken: ${event.apiToken}');

    try {
      LoginModel? data = await ApiProvider()
          .login(event.no_, newPassword, event.site, event.apiToken);
      // Implement actual login logic here
      print('data: $data');

      if (data != null) {
        emit(AuthSuccess(loginData: data));
      } else {
        emit(AuthFailure(error: 'Sai tài khoản hoặc mật khẩu'));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  void _onForgotPasswordRequested(
      ForgotPasswordRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Implement forgot password logic here
      await Future.delayed(Duration(seconds: 2)); // Simulating API call
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  void _onVerificationCodeSubmitted(
      VerificationCodeSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Implement verification code logic here
      await Future.delayed(Duration(seconds: 2)); // Simulating API call
      emit(VerificationCodeSuccess());
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  void _onPasswordResetRequested(
      PasswordResetRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Implement password reset logic here
      await Future.delayed(Duration(seconds: 2)); // Simulating API call
      emit(PasswordResetSuccess());
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  String convertPassword(String s) {
    // return s;
    String pw = "";
    List<int> bytes = utf8.encode(s);
    bytes = sha1.convert(bytes).bytes;
    for (var item in bytes) {
      pw += item.toString();
    }
    return pw;
  }
}
