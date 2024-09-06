import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm/model/employee_model.dart';
import 'package:hrm/model/login_model.dart';
import 'package:hrm/screens/login/bloc/bloc/auth_bloc.dart';
import 'package:hrm/screens/login/compoments/my_button.dart';
import 'package:hrm/screens/login/compoments/my_textfield.dart';
import 'package:hrm/screens/navigation/bloc/navigation_bloc.dart';
import 'package:hrm/screens/navigation/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _savePassword = false;
  late AuthBloc loginBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // khai báo tiện ích API
  late Future<List<dynamic>> futureData;

  void _onLoginButtonPressed(BuildContext context) {
    var list1 = _emailController.text.split("@");
    if (list1.length != 2) {
      Fluttertoast.showToast(
          msg: "Tài khoản không đúng",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red[300],
          textColor: Colors.white,
          fontSize: 13);
      return;
    }
    var list2 = list1[1].split(".");
    if (list2.length != 2) {
      Fluttertoast.showToast(
          msg: "Tài khoản không đúng",
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red[300],
          textColor: Colors.white,
          fontSize: 13);
      return;
    }
    User.site = list2[0].toUpperCase();

    final String password = _passwordController.text;
    String no_ = list1[0];

    BlocProvider.of<AuthBloc>(context)
        .add(LoginRequested(no_, password, User.site, ''));
  }

  @override
  void initState() {
    loginBloc = BlocProvider.of<AuthBloc>(context);

    // getUser();
    _emailController.text = 'admin@REETU.com';

    _passwordController.text = 'DA@@2024';

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getUser() async {
    if (Platform.isAndroid) {
      SharedPreferencesAndroid.registerWith();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _emailController.text = prefs.getString('user') ?? 'admin@REETU.com';
  }

  saveUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', _emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Đăng nhập',
          style: TextStyle(color: Colors.white, fontSize: 16),
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
            print('Login thành công');
            User.name = state.loginData.name!;
            User.no_ = state.loginData.no_!;
            User.site = state.loginData.site ?? 'REETU';
            User.token = state.loginData.jwTtoken!;

            print('token: ${User.token}');
            UserModel.id = (state.loginData.id != null)
                ? int.parse(state.loginData.id.toString())
                : 10088;

            saveUser();
            EasyLoading.dismiss();
            await Future.delayed(Duration(milliseconds: 150));
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NavigationScreen()),
                (Route<dynamic> route) => false);
          }
        },
        child: Stack(
          children: [
            // Đặt hình ảnh nền với độ mờ 20%

            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
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
