import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class PersonnelInfoPage extends StatefulWidget {
  final String name;

  const PersonnelInfoPage(this.name, {Key? key}) : super(key: key);

  @override
  _PersonnelInfoPageState createState() => _PersonnelInfoPageState();
}

class _PersonnelInfoPageState extends State<PersonnelInfoPage> {
  int selectedTab = 0; // 0: Trạng thái, 1: Tài sản, 2: Công việc

  void onTabSelected(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Thông tin nhân sự',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '@leminhduc1122003',
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Junior UI/UX Designer',
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(3),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        onTabSelected(0);
                      },
                      child: Text('Trạng thái'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            selectedTab == 0 ? Colors.white : Color(0XFF0e3b82),
                        backgroundColor:
                            selectedTab == 0 ? Colors.blue : Colors.blue[100],
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        onTabSelected(1);
                      },
                      child: AutoSizeText(
                        'Tài sản',
                        maxLines: 1,
                        minFontSize: 12,
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            selectedTab == 1 ? Colors.white : Color(0XFF0e3b82),
                        backgroundColor:
                            selectedTab == 1 ? Colors.blue : Colors.blue[100],
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        onTabSelected(2);
                      },
                      child: AutoSizeText(
                        'Công việc',
                        maxLines: 1,
                        minFontSize: 12,
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            selectedTab == 2 ? Colors.white : Color(0XFF0e3b82),
                        backgroundColor:
                            selectedTab == 2 ? Colors.blue : Colors.blue[100],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Divider(
              height: 5,
              color: Colors.grey[200],
              thickness: 4, // Thay đổi giá trị này để tăng độ dày
            ),

            // Nội dung thay đổi dựa trên nút đã chọn
            if (selectedTab == 0) ...[
              buildStatusContent(),
            ] else if (selectedTab == 1) ...[
              buildAssetsContent(),
            ] else if (selectedTab == 2) ...[
              buildWorkContent(),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildStatusContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Chi tiết',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Thêm nội dung trạng thái nhân sự với tiêu đề "Chi tiết"

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.email_outlined, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Email: ',
                  ),
                  Expanded(
                      child: Text(
                    'minhduc1122003',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.phone_outlined, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Số điện thoại: ',
                  ),
                  Expanded(
                      child: Text(
                    '0382006372',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.person_outlined, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Ngày sinh: ',
                  ),
                  Expanded(
                      child: Text(
                    '01/12/2003',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Địa chỉ: ',
                  ),
                  Expanded(
                      child: Text(
                    '14/8 Nguyễn Thái Sơn, Gò Vấp',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.group_outlined, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Quản lý: ',
                  ),
                  Expanded(
                      child: Text(
                    'Minh Đức',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAssetsContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tài sản',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Thêm nội dung về tài sản
          Text('Máy ảnh Sony A6400, Gimbal Zhiyun Smooth 4, ...'),
        ],
      ),
    );
  }

  Widget buildWorkContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Công việc',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Thêm nội dung về công việc
          Text('Hiệu suất công việc tháng 9/2023: 20 công việc hoàn thành.'),
        ],
      ),
    );
  }
}
