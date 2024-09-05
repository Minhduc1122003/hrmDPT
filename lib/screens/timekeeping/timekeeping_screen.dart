import 'package:flutter/material.dart';
import 'package:hrm/screens/DocumentTab/compoments/card_item_user.dart';
import 'package:hrm/screens/DocumentTab/compoments/tab_content_listUser.dart';
import 'package:hrm/screens/DocumentTab/compoments/uniti_button.dart';

class TimekeepingScreen extends StatefulWidget {
  const TimekeepingScreen();

  @override
  _TimekeepingScreenState createState() => _TimekeepingScreenState();
}

@override
class _TimekeepingScreenState extends State<TimekeepingScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.info,
                color: Colors.white,
                size: 20, // Kích thước icon search
              ),
              onPressed: () {
                // Xử lý khi nhấn vào icon search
              },
            ),
          ],
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
                  Tab(text: 'Chấm công'),
                  Tab(text: 'Lịch sử'),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          child: TabBarView(
            children: const [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Thứ 6, 27/01/2024'),
                        SizedBox(width: 20),
                        Text('07:56:23'),
                      ],
                    ),
                  ),
                ],
              ),
              Center(child: Text('Tạo đơn mới')),
            ],
          ),
        ),
      ),
    );
  }
}
