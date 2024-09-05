import 'package:flutter/material.dart';
import 'package:hrm/screens/DocumentTab/compoments/card_item_user.dart';

class TabContent extends StatefulWidget {
  @override
  _TabContentState createState() => _TabContentState();
}

class _TabContentState extends State<TabContent>
    with AutomaticKeepAliveClientMixin {
  late Future<List<Map<String, dynamic>>> _dataFuture;

  @override
  void initState() {
    super.initState();
    // Giả lập việc tải dữ liệu từ database
    _dataFuture = _fetchDatabaseData();
  }

  Future<List<Map<String, dynamic>>> _fetchDatabaseData() async {
    // Giả lập dữ liệu mẫu

    return [
      {
        'name': 'Nguyễn Văn A',
        'date': '2024-08-29',
        'position': 'Nhân viên',
        'shift': 'Ca sáng',
        'isApproved': true,
        'title': 'Xin nghỉ vì bệnh',
        'group': 'Nhóm 1',
        'describe': 'Nguyễn Văn A xin nghỉ vì lý do sức khỏe.',
      },
      {
        'name': 'Trần Thị B',
        'date': '2024-08-30',
        'position': 'Nhân viên',
        'shift': 'Ca chiều',
        'isApproved': false,
        'title': 'Xin nghỉ vì việc gia đình',
        'group': 'Nhóm 2',
        'describe': 'Trần Thị B xin nghỉ để giải quyết việc gia đình.',
      },
      {
        'name': 'Lê Văn C',
        'date': '2024-08-31',
        'position': 'Quản lý',
        'shift': 'Ca đêm',
        'isApproved': true,
        'title': 'Xin nghỉ vì lý do cá nhân',
        'group': 'Nhóm 3',
        'describe': 'Lê Văn C xin nghỉ vì lý do cá nhân.',
      },
      {
        'name': 'Phạm Thị D',
        'date': '2024-09-01',
        'position': 'Nhân viên',
        'shift': 'Ca sáng',
        'isApproved': false,
        'title': 'Xin nghỉ vì sự kiện quan trọng',
        'group': 'Nhóm 4',
        'describe': 'Phạm Thị D xin nghỉ vì tham dự sự kiện quan trọng.',
      },
      {
        'name': 'Hoàng Văn E',
        'date': '2024-09-02',
        'position': 'Nhân viên',
        'shift': 'Ca chiều',
        'isApproved': true,
        'title': 'Xin nghỉ phép năm',
        'group': 'Nhóm 5',
        'describe': 'Hoàng Văn E xin nghỉ phép năm.',
      },
      // Thêm 10 dữ liệu mới
      {
        'name': 'Nguyễn Thị F',
        'date': '2024-09-03',
        'position': 'Nhân viên',
        'shift': 'Ca sáng',
        'isApproved': true,
        'title': 'Xin nghỉ vì lý do cá nhân',
        'group': 'Nhóm 6',
        'describe': 'Nguyễn Thị F xin nghỉ vì lý do cá nhân.',
      },
      {
        'name': 'Bùi Văn G',
        'date': '2024-09-04',
        'position': 'Nhân viên',
        'shift': 'Ca chiều',
        'isApproved': false,
        'title': 'Xin nghỉ vì lý do sức khỏe',
        'group': 'Nhóm 7',
        'describe': 'Bùi Văn G xin nghỉ vì lý do sức khỏe.',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure keep-alive functionality

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Hiển thị vòng xoay tải dữ liệu trong khi chờ đợi
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Hiển thị thông báo lỗi nếu có vấn đề xảy ra
          return Center(child: Text('Lỗi khi tải dữ liệu'));
        } else {
          // Dữ liệu đã sẵn sàng, hiển thị danh sách
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return ExpandableCard(
                name: item['name'],
                date: item['date'],
                position: item['position'],
                shift: item['shift'],
                isApproved: item['isApproved'],
                title: item['title'],
                group: item['group'],
                describe: item['describe'],
              );
            },
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
