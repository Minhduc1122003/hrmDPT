class AppConfig {
  // Tạo một thể hiện duy nhất của lớp
  static final AppConfig _instance = AppConfig._internal();

  // Đặt các biến hoặc thuộc tính bạn cần lưu trữ ở đây
  String appName = 'MyApp';
  int themeIndex = 0;

  // Phương thức tạo instance từ private constructor
  factory AppConfig() {
    return _instance;
  }
  // Phương thức cập nhật themeIndex
  void updateThemeIndex(int index) {
    themeIndex++;
  }

  // Private constructor để đảm bảo không thể tạo thêm thể hiện mới từ bên ngoài
  AppConfig._internal();
}
