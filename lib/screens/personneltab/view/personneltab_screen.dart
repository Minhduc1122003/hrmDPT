import 'package:flutter/material.dart';
import 'package:hrm/model/listUser_model.dart';
import 'package:hrm/model/login_model.dart';
import 'package:hrm/network/api_provider.dart';
import 'package:hrm/screens/personneltab/view/personnel_info_page/personnel_info_page.dart';

class PersonnelTab extends StatefulWidget {
  const PersonnelTab({Key? key}) : super(key: key);

  @override
  _PersonnelTabState createState() => _PersonnelTabState();
}

class _PersonnelTabState extends State<PersonnelTab> {
  late ApiProvider _apiProvider;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  List<ListuserModel> _allUsers = []; // Danh sách toàn bộ người dùng
  List<ListuserModel> _displayedUsers = []; // Danh sách hiển thị theo tìm kiếm
  bool _isLoading = false;
  bool _hasMore = true;
  bool _isSearchLoading = false; // Thêm biến để kiểm soát trạng thái tìm kiếm
  int _page = 1;
  int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _apiProvider = ApiProvider();
    _loadAllUsers(); // Tải toàn bộ người dùng một lần duy nhất

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _hasMore) {
        _loadMore(); // Tải thêm dữ liệu từ danh sách đã lưu trữ
      }
    });

    // Lắng nghe thay đổi trong ô tìm kiếm
    _searchController.addListener(() {
      _filterUsers(_searchController.text);
    });
  }

  void _filterUsers(String query) {
    final lowerCaseQuery = query.toLowerCase();

    setState(() {
      searchQuery = query;
      _isSearchLoading = true; // Bắt đầu trạng thái tìm kiếm

      // Lọc danh sách người dùng
      _displayedUsers = _allUsers.where((user) {
        final nameLower = user.name?.toLowerCase();
        final noLower = user.no?.toLowerCase();
        return nameLower!.contains(lowerCaseQuery) ||
            noLower!.contains(lowerCaseQuery);
      }).toList();

      _isSearchLoading = false; // Kết thúc trạng thái tìm kiếm
    });
  }

  Future<void> _loadAllUsers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final allUsers = await _apiProvider.getListUser(User.site, User.token);

      setState(() {
        _allUsers = allUsers;
        _filterUsers(searchQuery); // Lọc ngay sau khi tải danh sách người dùng
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasMore = false;
      });
      print('Error loading users: $e');
    }
  }

  Future<void> _loadMore() async {
    if (_hasMore && !_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Tính toán chỉ số của trang tiếp theo
      final nextPageStartIndex = _page * _pageSize;
      final nextPageEndIndex =
          (_allUsers.length < nextPageStartIndex + _pageSize)
              ? _allUsers.length
              : nextPageStartIndex + _pageSize;

      if (nextPageStartIndex < _allUsers.length) {
        setState(() {
          _displayedUsers.addAll(_allUsers.sublist(nextPageStartIndex,
              nextPageEndIndex)); // Thêm dữ liệu vào danh sách hiển thị
          _isLoading = false;

          if (_displayedUsers.length >= _allUsers.length) {
            _hasMore = false; // Nếu đã tải hết dữ liệu, dừng tải thêm
          } else {
            _page++;
          }
        });
      } else {
        setState(() {
          _isLoading = false; // Đặt lại _isLoading nếu không còn dữ liệu để tải
        });
      }
    }
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                  prefixIcon: Icon(Icons.search, size: 20),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              searchQuery = '';
                              _filterUsers(
                                  ''); // Hiển thị lại toàn bộ danh sách
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
              height: MediaQuery.of(context).size.height - 200,
              child: Stack(
                children: [
                  ListView.builder(
                    controller: _scrollController,
                    itemCount: _displayedUsers.length + (_hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _displayedUsers.length) {
                        return Center(child: CircularProgressIndicator());
                      }

                      ListuserModel user = _displayedUsers[index];
                      return ListTile(
                        leading: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              child: CircleAvatar(
                                backgroundColor: null,
                                backgroundImage:
                                    AssetImage('assets/images/profile.png'),
                                radius: 23,
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          user.name.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          user.no.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing:
                            Icon(Icons.chevron_right, color: Colors.black54),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonnelInfoPage(user),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  if (_isLoading) // Hiển thị spinner khi phân trang đang tải
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
