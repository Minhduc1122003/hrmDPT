import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/screens/timekeeping/bloc/timekeeping_bloc.dart';
import 'dart:async';

import 'package:hrm/screens/timekeeping/compoments/timekeeping_history_calendar.dart'; // Thư viện cần thiết cho Timer

class TimekeepingScreen extends StatefulWidget {
  const TimekeepingScreen();

  @override
  _TimekeepingScreenState createState() => _TimekeepingScreenState();
}

class _TimekeepingScreenState extends State<TimekeepingScreen> {
  late Timer _timer;
  String _currentTime = _getCurrentTime();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _getCurrentTime();
      });
    });
  }

  static String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => TimekeepingBloc()..add(InitTime()),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
                size: 18,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Chấm công',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.info,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {
                  // Xử lý khi nhấn vào icon info
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.0),
              child: Container(
                height: 40,
                child: TabBar(
                  indicatorColor: Colors.blue,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.white,
                  tabs: const [
                    Tab(text: 'Chấm công'),
                    Tab(text: 'Lịch sử'),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocBuilder<TimekeepingBloc, TimekeepingBlocState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(state.dateFormat),
                              const SizedBox(width: 20),
                              Text(_currentTime), // Hiển thị thời gian hiện tại
                            ],
                          );
                        },
                      ),
                    ),
                    // Các thành phần UI khác ở đây
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height *
                        0.5, // Ví dụ: giới hạn chiều cao tối đa bằng 50% chiều cao màn hình
                  ),
                  child: TimekeepingHistoryCalendar(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
