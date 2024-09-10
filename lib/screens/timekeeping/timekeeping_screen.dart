import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/screens/timekeeping/bloc/timekeeping_bloc.dart';
import 'dart:async';
import 'package:hrm/screens/timekeeping/compoments/timekeeping_history_calendar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class TimekeepingScreen extends StatefulWidget {
  const TimekeepingScreen();

  @override
  _TimekeepingScreenState createState() => _TimekeepingScreenState();
}

class _TimekeepingScreenState extends State<TimekeepingScreen> {
  late Timer _timer;
  String _currentTime = _getCurrentTime();
  bool _isMapVisible = false;
  LatLng? _currentPosition;
  GoogleMapController? _mapController;
  final LatLng _targetPosition =
      LatLng(10.830126, 106.618113); // Tọa độ nơi làm việc
  final double banKinh = 50;
  @override
  void initState() {
    super.initState();
    _startTimer();
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

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

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

    // Tọa độ hiện tại
    double currentLatitude = _currentPosition!.latitude;
    double currentLongitude = _currentPosition!.longitude;

    // Tọa độ mục tiêu
    double targetLatitude = 10.830126;
    double targetLongitude = 106.618113;

    // Tính khoảng cách
    double distance = Geolocator.distanceBetween(
      currentLatitude,
      currentLongitude,
      targetLatitude,
      targetLongitude,
    );

    // In tọa độ hiện tại, tọa độ mục tiêu và khoảng cách ra console
    print(
        'Tọa độ hiện tại: Latitude: $currentLatitude, Longitude: $currentLongitude');
    print(
        'Tọa độ mục tiêu: Latitude: $targetLatitude, Longitude: $targetLongitude');
    print('Distance: $distance meters');

    // Kiểm tra khoảng cách và hiển thị thông báo
    if (distance <= banKinh) {
      EasyLoading.showSuccess('Chấm công thành công');
      // Thực hiện các hành động khi chấm công thành công
    } else {
      EasyLoading.showError(
          'Bạn không nằm trong bán kính cho phép để chấm công');
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
                onPressed: () {
                  // Xử lý khi nhấn vào icon info
                },
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
          body: Stack(
            children: [
              TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<TimekeepingBloc,
                              TimekeepingBlocState>(
                            builder: (context, state) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.date_range_outlined,
                                            color: Colors.green,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(state.dateFormat),
                                        ],
                                      ),
                                      const SizedBox(width: 20),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            color: Colors.blue,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(_currentTime),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  _isMapVisible
                                      ? Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              220,
                                          child: GoogleMap(
                                            initialCameraPosition:
                                                CameraPosition(
                                              target: _currentPosition!,
                                              zoom: 15,
                                            ),
                                            onMapCreated: (GoogleMapController
                                                controller) {
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
                                                // Bán kính 50m
                                                strokeColor: Colors.blue
                                                    .withOpacity(0.5),
                                                strokeWidth: 2,
                                                fillColor: Colors.blue
                                                    .withOpacity(0.2),
                                              ),
                                            },
                                          ),
                                        )
                                      : ElevatedButton(
                                          onPressed: _requestLocationPermission,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 15,
                                            ),
                                          ),
                                          child: Text(
                                            'Truy cập vị trí',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                  SizedBox(height: 20),
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
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: ElevatedButton(
                  onPressed: _checkIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // background (button) color
                    foregroundColor: Colors.white, // text color
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Chấm công',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
