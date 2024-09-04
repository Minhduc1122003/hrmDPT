import 'package:flutter/material.dart';
import 'package:hrm/screens/hometab/view/donTu/compoments/card_item_user.dart';
import 'package:hrm/screens/hometab/view/donTu/compoments/uniti_button.dart';

class QuanLyDonTuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
            'Quản lý đơn từ',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0), // Đặt chiều cao của AppBar

            child: Container(
              height: 40, // Chiều cao của TabBar

              child: TabBar(
                indicatorColor: Colors.blue,
                dividerHeight: 0,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft:
                        Radius.circular(0), // Không bo góc dưới bên trái
                    bottomRight: Radius.circular(0),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.white,
                tabs: const [
                  Tab(text: 'Của bạn'),
                  Tab(text: 'Quản lý'),
                  Tab(text: 'Tạo đơn'),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(
            children: [
              _TabContent(),
              Center(child: Text('Tạo đơn mới')),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UtilitySection(
                      buttons: [
                        UtilityButton(
                          colorText: Colors.blue,
                          color: Colors.pink,
                          title: 'Cộng tác dưới 7 ngày',
                          onPressed: () {},
                        ),
                      ],
                    ),
                    UtilitySection(
                      buttons: [
                        UtilityButton(
                          colorText: Colors.blue,
                          color: Colors.pink,
                          title: 'Cộng tác dưới 7 ngày',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TabContent extends StatefulWidget {
  @override
  __TabContentState createState() => __TabContentState();
}

class __TabContentState extends State<_TabContent>
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
      // {
      //   'name': 'Vũ Thị H',
      //   'date': '2024-09-05',
      //   'position': 'Nhân viên',
      //   'shift': 'Ca đêm',
      //   'isApproved': true,
      //   'title': 'Xin nghỉ vì việc gia đình',
      //   'group': 'Nhóm 8',
      //   'describe': 'Vũ Thị H xin nghỉ để giải quyết việc gia đình.',
      // },
      // {
      //   'name': 'Nguyễn Văn I',
      //   'date': '2024-09-06',
      //   'position': 'Quản lý',
      //   'shift': 'Ca sáng',
      //   'isApproved': false,
      //   'title': 'Xin nghỉ vì sự kiện quan trọng',
      //   'group': 'Nhóm 9',
      //   'describe': 'Nguyễn Văn I xin nghỉ để tham dự sự kiện quan trọng.',
      // },
      // {
      //   'name': 'Trần Thị J',
      //   'date': '2024-09-07',
      //   'position': 'Nhân viên',
      //   'shift': 'Ca chiều',
      //   'isApproved': true,
      //   'title': 'Xin nghỉ phép năm',
      //   'group': 'Nhóm 10',
      //   'describe': 'Trần Thị J xin nghỉ phép năm.',
      // },
      // {
      //   'name': 'Lê Văn K',
      //   'date': '2024-09-08',
      //   'position': 'Nhân viên',
      //   'shift': 'Ca đêm',
      //   'isApproved': true,
      //   'title': 'Xin nghỉ vì lý do cá nhân',
      //   'group': 'Nhóm 11',
      //   'describe': 'Lê Văn K xin nghỉ vì lý do cá nhân.',
      // },
      // {
      //   'name': 'Phạm Thị L',
      //   'date': '2024-09-09',
      //   'position': 'Nhân viên',
      //   'shift': 'Ca sáng',
      //   'isApproved': false,
      //   'title': 'Xin nghỉ vì lý do sức khỏe',
      //   'group': 'Nhóm 12',
      //   'describe': 'Phạm Thị L xin nghỉ vì lý do sức khỏe.',
      // },
      // {
      //   'name': 'Hoàng Văn M',
      //   'date': '2024-09-10',
      //   'position': 'Nhân viên',
      //   'shift': 'Ca chiều',
      //   'isApproved': true,
      //   'title': 'Xin nghỉ vì việc gia đình',
      //   'group': 'Nhóm 13',
      //   'describe': 'Hoàng Văn M xin nghỉ để giải quyết việc gia đình.',
      // },
      // {
      //   'name': 'Nguyễn Thị N',
      //   'date': '2024-09-11',
      //   'position': 'Nhân viên',
      //   'shift': 'Ca đêm',
      //   'isApproved': true,
      //   'title': 'Xin nghỉ vì sự kiện quan trọng',
      //   'group': 'Nhóm 14',
      //   'describe': 'Nguyễn Thị N xin nghỉ để tham dự sự kiện quan trọng.',
      // },
      // {
      //   'name': 'Bùi Văn O',
      //   'date': '2024-09-12',
      //   'position': 'Nhân viên',
      //   'shift': 'Ca sáng',
      //   'isApproved': false,
      //   'title': 'Xin nghỉ phép năm',
      //   'group': 'Nhóm 15',
      //   'describe': 'Bùi Văn O xin nghỉ phép năm.',
      // },
      // {
      //   'name': 'Vũ Thị P',
      //   'date': '2024-09-13',
      //   'position': 'Nhân viên',
      //   'shift': 'Ca chiều',
      //   'isApproved': true,
      //   'title': 'Xin nghỉ vì lý do cá nhân',
      //   'group': 'Nhóm 16',
      //   'describe': 'Vũ Thị P xin nghỉ vì lý do cá nhân.',
      // },
      // {
      //   'name': 'Nguyễn Văn Q',
      //   'date': '2024-09-14',
      //   'position': 'Quản lý',
      //   'shift': 'Ca đêm',
      //   'isApproved': true,
      //   'title': 'Xin nghỉ vì lý do sức khỏe',
      //   'group': 'Nhóm 17',
      //   'describe': 'Nguyễn Văn Q xin nghỉ vì lý do sức khỏe.',
      // },
      // {
      //   'name': 'Trần Thị R',
      //   'date': '2024-09-15',
      //   'position': 'Nhân viên',
      //   'shift': 'Ca sáng',
      //   'isApproved': false,
      //   'title': 'Xin nghỉ vì việc gia đình',
      //   'group': 'Nhóm 18',
      //   'describe': 'Trần Thị R xin nghỉ để giải quyết việc gia đình.',
      // },
      // {
      //   'name': 'Lê Văn S',
      //   'date': '2024-09-16',
      //   'position': 'Nhân viên',
      //   'shift': 'Ca chiều',
      //   'isApproved': true,
      //   'title': 'Xin nghỉ vì sự kiện quan trọng',
      //   'group': 'Nhóm 19',
      //   'describe': 'Lê Văn S xin nghỉ để tham dự sự kiện quan trọng.',
      // },
      // {
      //   'name': 'Phạm Thị T',
      //   'date': '2024-09-17',
      //   'position': 'Nhân viên',
      //   'shift': 'Ca đêm',
      //   'isApproved': true,
      //   'title': 'Xin nghỉ phép năm',
      //   'group': 'Nhóm 20',
      //   'describe': 'Phạm Thị T xin nghỉ phép năm.',
      // },
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
