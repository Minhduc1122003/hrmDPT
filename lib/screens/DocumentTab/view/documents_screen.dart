import 'package:flutter/material.dart';
import 'package:hrm/screens/DocumentTab/compoments/card_item_user.dart';
import 'package:hrm/screens/DocumentTab/compoments/tab_content_listUser.dart';
import 'package:hrm/screens/DocumentTab/compoments/uniti_button.dart';

class DocumentTab extends StatefulWidget {
  const DocumentTab({Key? key}) : super(key: key);

  @override
  _DocumentTabState createState() => _DocumentTabState();
}

@override
class _DocumentTabState extends State<DocumentTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Quản lý đơn từ',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30.0), // Đặt chiều cao của AppBar
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
          height: MediaQuery.of(context).size.height - 200,
          child: TabBarView(
            children: [
              TabContent(),
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
