import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hrm/screens/personneltab/view/personnel_info_page/personnel_info_page.dart';

class PersonnelTab extends StatefulWidget {
  const PersonnelTab({Key? key}) : super(key: key);

  @override
  _PersonnelTabState createState() => _PersonnelTabState();
}

class _PersonnelTabState extends State<PersonnelTab> {
  List<Map<String, dynamic>> allPersonnel = [
    {
      "name": "Phạm Tùng Dương",
      "role": "Senior UI/UX Designer",
      "active": true
    },
    {"name": "Bùi Quang Huy", "role": "Junior UI/UX Designer", "active": false},
    {"name": "Đặng Trung Đức", "role": "Junior UI/UX Designer", "active": true},
    {"name": "Phạm Minh Tuấn", "role": "3D Artist Game", "active": true},
    {"name": "Đào Trung Quân", "role": "2D Artist Game", "active": false},
    {"name": "Bùi Quang Nam", "role": "Junior UI/UX Designer", "active": false},
    {"name": "Đặng Trung Đức", "role": "Junior UI/UX Designer", "active": true},
    {"name": "Phạm Minh Tuấn", "role": "3D Artist Game", "active": true},
    {"name": "Đào Trung Quân", "role": "2D Artist Game", "active": false},
  ];

  List<Map<String, dynamic>> displayedPersonnel = [];
  bool showAllActive = true;
  bool showActive = true;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    updateDisplayedPersonnel('all');
  }

  void updateDisplayedPersonnel(String tab) {
    List<Map<String, dynamic>> filteredList;

    if (tab == 'all') {
      filteredList = List.from(allPersonnel);
      showAllActive = true;
      showActive = false;
    } else if (tab == 'active') {
      filteredList = allPersonnel.where((person) => person['active']).toList();
      showAllActive = false;
      showActive = true;
    } else if (tab == 'inactive') {
      filteredList = allPersonnel.where((person) => !person['active']).toList();
      showAllActive = false;
      showActive = false;
    } else {
      filteredList = List.from(allPersonnel);
    }

    setState(() {
      displayedPersonnel = filteredList;
      filterPersonnel();
    });
  }

  void filterPersonnel() {
    setState(() {
      if (showAllActive) {
        displayedPersonnel = allPersonnel
            .where((person) => person['name']
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
            .toList();
      } else if (showActive) {
        displayedPersonnel = allPersonnel
            .where((person) =>
                person['active'] &&
                person['name']
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()))
            .toList();
      } else {
        displayedPersonnel = allPersonnel
            .where((person) =>
                !person['active'] &&
                person['name']
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Quản lý nhân sự',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        updateDisplayedPersonnel('all');
                      },
                      child: Text('Tất cả (${allPersonnel.length})'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            showAllActive ? Colors.white : Color(0XFF0e3b82),
                        backgroundColor:
                            showAllActive ? Colors.blue : Colors.blue[100],
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        updateDisplayedPersonnel('active');
                      },
                      child: AutoSizeText(
                        'Đang hoạt động (${allPersonnel.where((p) => p['active']).length})',
                        maxLines: 1,
                        minFontSize: 12,
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            showActive ? Colors.white : Color(0XFF0d8253),
                        backgroundColor:
                            showActive ? Color(0XFF067d4d) : Color(0XFFd0e3cf),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        updateDisplayedPersonnel('inactive');
                      },
                      child: AutoSizeText(
                        'Không hoạt động (${allPersonnel.where((p) => !p['active']).length})',
                        maxLines: 1,
                        minFontSize: 12,
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: (!showAllActive && !showActive)
                            ? Colors.white
                            : Color(0XFFb52429),
                        backgroundColor: (!showAllActive && !showActive)
                            ? Color(0XFFc74850)
                            : Color(0XFFe3cfcf),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    filterPersonnel();
                  });
                },
                decoration: InputDecoration(
                  isDense:
                      true, // Thuộc tính này giúp giảm chiều cao của TextField
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0), // Giảm padding để giảm chiều cao
                  prefixIcon: Icon(Icons.search,
                      size: 20), // Điều chỉnh kích thước icon nếu cần
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              searchQuery = '';
                              filterPersonnel();
                            });
                          },
                        )
                      : null,
                  hintText: 'Tìm kiếm nhân sự',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height -
                  270, // Adjust height as needed
              child: ListView.builder(
                itemCount: displayedPersonnel.length,
                itemBuilder: (context, index) {
                  final person = displayedPersonnel[index];
                  return ListTile(
                    leading: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: CircleAvatar(
                            backgroundColor: null,
                            backgroundImage:
                                AssetImage('assets/images/profile.png'),
                            radius: 23,
                          ),
                        ),
                        if (person['active'] != null)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 13,
                              height: 13,
                              decoration: BoxDecoration(
                                color: person['active']
                                    ? Colors.green
                                    : Color(0XFFb52429),
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: Text(
                      person['name'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      person['role'],
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: Icon(Icons.chevron_right, color: Colors.black54),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PersonnelInfoPage(person['name'].toString()),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
