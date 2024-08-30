import 'package:flutter/material.dart';

class QuanLyDonTuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Số lượng tab bạn có
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue, // Đổ màu nền từ title xuống các tab
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop(); // Quay lại trang trước
            },
          ),
          title: Text(
            'Quản lý đơn từ',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true, // Đặt title nằm giữa
          bottom: TabBar(
            indicator: BoxDecoration(
              color: Colors.white, // Nền trắng của tab được chọn
              borderRadius: BorderRadius.circular(4.0), // Bo tròn các góc tab
            ),
            indicatorSize: TabBarIndicatorSize
                .tab, // Kích thước của indicator bằng với tab
            labelColor: Colors.blue, // Màu chữ của tab được chọn
            unselectedLabelColor:
                Colors.white, // Màu chữ của các tab không được chọn
            tabs: [
              Tab(text: 'Của bạn'),
              Tab(text: 'Quản lý'),
              Tab(text: 'Tạo đơn'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: ListView.builder(
                itemCount: 10, // Số lượng đơn từ giả định
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Padding(
                      padding: EdgeInsets.all(8), // Padding cho Card
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Hàng đầu tiên: Avatar và button "Chưa phê duyệt"
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/profile.png'), // Đường dẫn tới ảnh đại diện
                              ),
                              SizedBox(
                                  width:
                                      16), // Khoảng cách giữa avatar và button
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Xử lý sự kiện khi nhấn vào button
                                    },
                                    child: Text('Chưa phê duyệt'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  16), // Khoảng cách giữa hàng đầu tiên và hàng thứ hai
                          // Hàng thứ hai: Tên nhân viên và ngày sinh
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Tên nhân viên',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Spacer(), // Khoảng trống linh hoạt để đẩy thông tin ngày sinh sang phải
                              Text('20/08/2023'),
                            ],
                          ),
                          SizedBox(
                              height:
                                  8), // Khoảng cách giữa hàng thứ hai và hàng thứ ba
                          // Hàng thứ ba: Chức vụ và ca làm
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Nhân viên R&D',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Spacer(), // Khoảng trống linh hoạt để đẩy thông tin ca làm sang phải
                              Text('8:00-12:00'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(child: Text('Danh sách quản lý')),
            Center(child: Text('Tạo đơn mới')),
          ],
        ),
      ),
    );
  }
}
