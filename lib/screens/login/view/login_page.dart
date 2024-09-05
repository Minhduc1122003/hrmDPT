import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrm/screens/login/bloc/bloc/auth_bloc.dart';
import 'package:hrm/screens/login/compoments/my_button.dart';
import 'package:hrm/screens/login/compoments/my_textfield.dart';
import 'package:hrm/screens/navigation/bloc/navigation_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _savePassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // khai báo tiện ích API
  late Future<List<dynamic>> futureData;

  void _onLoginButtonPressed(BuildContext context) {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    BlocProvider.of<AuthBloc>(context)
        .add(LoginRequested(email: email, password: password));
  }

  @override
  void initState() {
    _emailController.text = 'orcinus10';
    _passwordController.text = '123123';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0XFF6F3CD7),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
            size: 16,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Đăng nhập',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthFailure) {
            print('login LoginError');
            EasyLoading.showError('Sai tài khoản hoặc mật khẩu');
          } else if (state is AuthLoading) {
            EasyLoading.show();
          } else if (state is AuthSuccess) {
            EasyLoading.dismiss();
            await Future.delayed(Duration(milliseconds: 150));
            context.read<NavigationBloc>().add(NavigationTabChanged(1));
          }
        },
        child: Stack(
          children: [
            // Đặt hình ảnh nền với độ mờ 20%
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.7),
                  BlendMode.srcOver,
                ),
                child: Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: keyboardHeight),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.message,
                              size: 100,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Text(
                              'Welcome back',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 40),

                            // Email textfield
                            MyTextfield(
                              placeHolder: "Email",
                              controller: _emailController,
                            ),
                            const SizedBox(height: 20),

                            // Password textfield
                            MyTextfield(
                              isPassword: true,
                              placeHolder: "Mật khẩu",
                              controller: _passwordController,
                            ),
                            _savePassForgotPassword(),
                            const SizedBox(height: 10),
                            MyButton(
                              fontsize: 16,
                              paddingText: 16,
                              text: 'ĐĂNG NHẬP',
                              onTap: () => _onLoginButtonPressed(context),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _savePassForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: _savePassword,
              onChanged: (bool? value) {
                setState(() {
                  _savePassword = value ?? false;
                });
              },
            ),
            const Text('Lưu mật khẩu'),
          ],
        ),
        TextButton(
          onPressed: () {
            // TODO: Handle forgot password action
            print('Quên mật khẩu');
          },
          child: const Text('Quên mật khẩu?'),
        ),
      ],
    );
  }
}
