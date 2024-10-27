import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:hrm/network/notification/notification.dart';

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {
  @override
  void onStart(DateTime timestamp) {
    print('Service started');
    NotificationHelper.showNotification("đã bắt đầu service");
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    print('Foreground service is running');
  }

  @override
  void onDestroy(DateTime timestamp) {
    print('Service stopped');
  }

  @override
  void onReceiveData(Object data) {
    print('Received data: $data');
  }

  @override
  void onNotificationButtonPressed(String id) {
    print('Notification button pressed: $id');
  }

  @override
  void onNotificationPressed() {
    print('Notification pressed');
  }

  @override
  void onNotificationDismissed() {
    print('Notification dismissed');
  }
}
