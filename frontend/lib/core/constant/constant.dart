import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static late final String backendUri;

  /// Call this once (e.g. in main()).
  /// Optionally pass a custom env file name.
  static Future<void> init({String envFile = ".env"}) async {
    // Load .env only if not already loaded
    if (dotenv.env.isEmpty) {
      await dotenv.load(fileName: envFile);
    }

    final raw = dotenv.env['BACKEND_URL']?.trim();
    if (raw == null || raw.isEmpty) {
      throw StateError(
          'FATAL ERROR: BACKEND_URL is not set in $envFile.\n'
              'Please add: BACKEND_URL=http://<your-host>:<port>'
      );
    }

    String url = raw;

    // Replace localhost with emulator host only on Android (and not on web)
    if (!kReleaseMode && !kIsWeb) {
      try {
        if (Platform.isAndroid) {
          url = url.replaceAll('localhost', '10.0.2.2');
          url = url.replaceAll('127.0.0.1', '10.0.2.2');
        }
      } catch (_) {
        // In case Platform.* isn't available on some platform, ignore.
      }
    }

    backendUri = url;
  }
}
