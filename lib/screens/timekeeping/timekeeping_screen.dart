import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/screens/timekeeping/bloc/timekeeping_bloc.dart';

class TimekeepingScreen extends StatefulWidget {
  const TimekeepingScreen();

  @override
  _TimekeepingScreenState createState() => _TimekeepingScreenState();
}

class _TimekeepingScreenState extends State<TimekeepingScreen> {
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
              Column(
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
                            Text(state.realTimeClock),
                          ],
                        );
                      },
                    ),
                  ),
                  // Các thành phần UI khác ở đây
                ],
              ),
              const Center(child: Text('Tạo đơn mới')),
            ],
          ),
        ),
      ),
    );
  }
}
