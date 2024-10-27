import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hrm/firebase_options.dart';
import 'package:hrm/network/firebase_api.dart';
import 'package:hrm/network/notification/notification.dart';
import 'package:hrm/screens/navigation/navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/screens/hometab/bloc/hometab_bloc.dart';
import 'package:hrm/screens/login/bloc/bloc/auth_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await Firebas000000000eApi().initNotifications();
  runApp(const MyApp());
}

// 42aa4f00-1cc3-4f16-9b01-50b31954a3b3

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
