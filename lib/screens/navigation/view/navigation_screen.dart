import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/model/login_model.dart';
import 'package:hrm/screens/DocumentTab/documentTab.dart';
import 'package:hrm/screens/hometab/bloc/hometab_bloc.dart';
import '../../../theme/theme.dart';
import '../../hometab/hometab.dart';
import '../../personneltab/personneltab.dart';
import '../navigation.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late List<Widget> _screens;
  DateTime? lastPressed; // Thời gian của lần nhấn nút quay lại gần nhất

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeTab(key: ValueKey('home')),
      PersonnelTab(key: ValueKey('personnel')),
      Container(
          key: ValueKey('recruitment'),
          child: Center(child: Text('Recruitment'))),
      DocumentTab(key: ValueKey('document')),
      Container(
          key: ValueKey('meetings'), child: Center(child: Text('Meetings'))),
    ];
  }

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    final maxDuration = Duration(
        seconds: 2); // Thời gian cho phép giữa hai lần nhấn nút quay lại
    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        lastPressed == null || now.difference(lastPressed!) > maxDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      lastPressed =
          DateTime.now(); // Cập nhật thời gian của lần nhấn nút quay lại
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Nhấn lần nữa để thoát',
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          duration: maxDuration,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 10),
          margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
        ),
      );
      return false; // Không thoát khỏi ứng dụng
    }
    return true; // Thoát khỏi ứng dụng
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Đăng ký phương thức xử lý nhấn nút quay lại
      child: BlocProvider(
        create: (context) => HomeTabBloc()
          ..add(LoadHomeTabData(
              User.name, '5', '3', '90', '20')),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              BlocBuilder<NavigationBloc, NavigationState>(
                buildWhen: (previous, current) =>
                    previous.index != current.index,
                builder: (context, state) {
                  if (state.index == 1) {
                    context.read<HomeTabBloc>().add(IncrementCount());
                    print('đã add IncrementCount ');
                  }
                  return IndexedStack(
                    index: state.index,
                    children: _screens,
                  );
                },
              ),
              Positioned(
                left: 15,
                right: 15,
                bottom: 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: BottomNavigation(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
