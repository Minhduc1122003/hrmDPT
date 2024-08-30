import 'package:flutter/material.dart';
import 'package:hrm/screens/hometab/bloc/hometab_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/navigation/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NavigationBloc(),
          ),
          BlocProvider(
            create: (context) => HomeTabBloc(),
          ),
        ],
        child: NavigationScreen(),
      ),
    );
  }
}
