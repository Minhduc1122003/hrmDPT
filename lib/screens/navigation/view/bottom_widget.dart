import 'package:flutter/material.dart';
import 'package:hrm/theme/theme.dart';
import '../navigation.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      buildWhen: (previous, current) => previous.index != current.index,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          color: AppTheme.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(context, Icons.home, 'Trang chủ', 0, state.index),
              _buildNavItem(context, Icons.people, 'Nhân sự', 1, state.index),
              _buildNavItem(context, Icons.work, 'Tuyển dụng', 2, state.index),
              _buildNavItem(context, Icons.file_copy, 'Đơn từ', 3, state.index),
              _buildNavItem(
                  context, Icons.meeting_room, 'Cuộc họp', 4, state.index),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label,
      int index, int currentIndex) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () =>
          context.read<NavigationBloc>().add(NavigationTabChanged(index)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding:
            EdgeInsets.symmetric(horizontal: isSelected ? 10 : 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                color: isSelected ? Colors.blue : Colors.white, size: 20),
            if (isSelected) ...[
              SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
