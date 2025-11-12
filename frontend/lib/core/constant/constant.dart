import 'dart:io';

class Constants {
  static String get backendUri {
    // For web platform
    if (Uri.base.toString().contains('localhost')) {
      return 'http://localhost:8000';
    }

    // For Android emulator
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000';
    }

    // For iOS simulator
    if (Platform.isIOS) {
      return 'http://127.0.0.1:8000';
    }

    // Default fallback (you can replace this with your production API URL)
    return 'http://localhost:8000';
  }
}

