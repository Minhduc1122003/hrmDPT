import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrm/screens/hometab/bloc/hometab_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/screens/login/bloc/bloc/auth_bloc.dart';

import 'screens/navigation/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider(
          create: (context) => HomeTabBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NavigationScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
