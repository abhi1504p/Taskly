import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static final String backendUri = _getBackendUrl();

  static String _getBackendUrl() {
    final url = dotenv.env['BACKEND_URL'];
    if (url == null || url.isEmpty) {
      throw StateError(
          'FATAL ERROR: BACKEND_URL is not set in your .env file. '
          'Please create a .env file in the root of the `frontend` directory and add the line: '
          'BACKEND_URL=http://your.local.ip.address:8000');
    }
    return url;
  }
}

