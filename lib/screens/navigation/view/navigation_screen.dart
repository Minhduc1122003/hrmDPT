import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeTab(key: ValueKey('home')),
      PersonnelTab(key: ValueKey('personnel')),
      Container(
          key: ValueKey('recruitment'),
          child: Center(child: Text('Recruitment'))),
      Container(key: ValueKey('forms'), child: Center(child: Text('Forms'))),
      Container(
          key: ValueKey('meetings'), child: Center(child: Text('Meetings'))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeTabBloc()..add(LoadHomeTabData('0', '1', '3', '90', '0')),
      child: Scaffold(
        body: Stack(
          children: [
            BlocBuilder<NavigationBloc, NavigationState>(
              buildWhen: (previous, current) => previous.index != current.index,
              builder: (context, state) {
                // Khi index là 1, gọi sự kiện IncrementCount
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
    );
  }
}
