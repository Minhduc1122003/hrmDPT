import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../hometab/hometab.dart';
import '../../personneltab/personneltab.dart';
import '../navigation.dart';

class NavigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          BlocBuilder<NavigationBloc, NavigationState>(
            buildWhen: (previous, current) =>
                previous.runtimeType != current.runtimeType,
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _buildScreen(state),
              );
            },
          ),
          // Bottom Navigation Bar
          Positioned(
            left: 15,
            right: 15,
            bottom: 15,
            child: ClipRRect(
              // Add ClipRRect here
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
    );
  }

  Widget _buildScreen(NavigationState state) {
    if (state is HomeState) {
      return HomeTab();
    } else if (state is PersonnelState) {
      return PersonnelTab(key: ValueKey('personnel'));
    } else {
      return Container(key: ValueKey('default'));
    }
  }
}
