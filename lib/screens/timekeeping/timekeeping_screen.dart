import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrm/screens/timekeeping/bloc/timekeeping_bloc.dart';
import 'package:hrm/screens/timekeeping/compoments/timekeeping_history_calendar.dart';
import 'package:image_picker/image_picker.dart';

class TimekeepingScreen extends StatefulWidget {
  const TimekeepingScreen();

  @override
  _TimekeepingScreenState createState() => _TimekeepingScreenState();
}

class _TimekeepingScreenState extends State<TimekeepingScreen> {
  late Timer _timer;
  String _currentTime = _getCurrentTime();
  bool _isMapVisible = false;
  bool _isLocationPermissionGranted = false;
  LatLng? _currentPosition;
  GoogleMapController? _mapController;
  final LatLng _targetPosition =
      LatLng(10.830126, 106.618113); // Tọa độ nơi làm việc
  final double banKinh = 50;
  String? _selectedImagePath; // Biến lưu đường dẫn ảnh đã chọn

  @override
  void initState() {
    super.initState();
    _startTimer();
    _checkLocationPermission();
  }

  @override
  void dispose() {
    _timer.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _getCurrentTime();
      });
    });
  }

  static String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _requestLocation();
      setState(() {
        _isLocationPermissionGranted = true;
      });
    }
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _requestLocation();
      setState(() {
        _isLocationPermissionGranted = true;
      });
    }
  }

  Future<void> _requestLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _isMapVisible = true;
    });
  }

  void _checkIn() {
    if (_currentPosition == null) {
      EasyLoading.showError('Không thể lấy vị trí hiện tại');
      return;
    }

    double currentLatitude = _currentPosition!.latitude;
    double currentLongitude = _currentPosition!.longitude;

    double distance = Geolocator.distanceBetween(
      currentLatitude,
      currentLongitude,
      _targetPosition.latitude,
      _targetPosition.longitude,
    );

    if (distance <= banKinh) {
      EasyLoading.showSuccess('Chấm công thành công lúc $_currentTime');
    } else {
      EasyLoading.showError(
          'Bạn không nằm trong bán kính cho phép để chấm công');
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera, // Sử dụng camera để chụp ảnh
    );

    if (image != null) {
      setState(() {
        _selectedImagePath = image.path; // Lưu đường dẫn ảnh đã chọn
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => TimekeepingBloc()..add(InitTime()),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined,
                  color: Colors.white, size: 18),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Chấm công',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.info, color: Colors.white, size: 20),
                onPressed: () {},
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.0),
              child: Container(
                height: 40,
                child: TabBar(
                  dividerHeight: 0,
                  indicatorColor: Colors.blue,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.white,
                  tabs: const [Tab(text: 'Chấm công'), Tab(text: 'Lịch sử')],
                ),
              ),
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocBuilder<TimekeepingBloc, TimekeepingBlocState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Icon(Icons.date_range_outlined,
                                          color: Colors.green, size: 18),
                                      const SizedBox(width: 3),
                                      Text(state.dateFormat),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time,
                                          color: Colors.blue, size: 18),
                                      const SizedBox(width: 3),
                                      Text(_currentTime),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              _isMapVisible
                                  ? Container(
                                      height: 200,
                                      child: GoogleMap(
                                        initialCameraPosition: CameraPosition(
                                          target: _currentPosition!,
                                          zoom: 15,
                                        ),
                                        onMapCreated:
                                            (GoogleMapController controller) {
                                          _mapController = controller;
                                        },
                                        markers: {
                                          Marker(
                                            markerId:
                                                MarkerId('currentLocation'),
                                            position: _currentPosition!,
                                          ),
                                        },
                                        circles: {
                                          Circle(
                                            circleId: CircleId('radius'),
                                            center: _currentPosition!,
                                            radius: banKinh,
                                            strokeColor:
                                                Colors.blue.withOpacity(0.5),
                                            strokeWidth: 2,
                                            fillColor:
                                                Colors.blue.withOpacity(0.2),
                                          ),
                                        },
                                      ),
                                    )
                                  : !_isLocationPermissionGranted
                                      ? ElevatedButton(
                                          onPressed: _requestLocationPermission,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 15),
                                          ),
                                          child: Text(
                                            'Truy cập vị trí',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      : Container(),
                              // Nút chụp ảnh và hiển thị ảnh đã chọn
                              GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  width: MediaQuery.of(context).size.width -
                                      10, // Chiều rộng của màn hình - lề
                                  constraints: BoxConstraints(
                                    minHeight:
                                        300, // Chiều cao tối thiểu nếu nội dung nhỏ hơn 100
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                    image: _selectedImagePath != null
                                        ? DecorationImage(
                                            image: FileImage(
                                                File(_selectedImagePath!)),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: _selectedImagePath == null
                                      ? Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.image,
                                                color: Colors.blue,
                                                size: 50,
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                'Nhấn để chụp',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment
                                              .bottomRight, // Đặt nội dung ở góc dưới bên phải
                                          child: Container(
                                            padding: EdgeInsets.all(
                                                10), // Padding xung quanh nội dung
                                            margin: EdgeInsets.all(
                                                10), // Margin để tạo khoảng cách với cạnh hình ảnh
                                            decoration: BoxDecoration(
                                              color: Colors
                                                  .blue, // Màu nền của text
                                              borderRadius: BorderRadius.circular(
                                                  10), // Border radius cho background
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize
                                                  .min, // Chỉ chiếm không gian cần thiết
                                              children: [
                                                Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                  size: 14,
                                                ), // Icon phù hợp
                                                SizedBox(
                                                    width:
                                                        3), // Khoảng cách giữa icon và text
                                                Text(
                                                  'Chụp ảnh khác',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12), // Màu chữ
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ),
                              ),

                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: double
                                      .infinity, // Chiều rộng đầy đủ màn hình
                                  padding: EdgeInsets.all(
                                      8.0), // Khoảng cách xung quanh nút
                                  child: ElevatedButton(
                                    onPressed: _checkIn,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.green, // Màu nền của nút
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                    ),
                                    child: Text(
                                      'Chấm công',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.5,
                  ),
                  child: TimekeepingHistoryCalendar(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
