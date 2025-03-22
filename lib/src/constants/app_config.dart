import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  AppConfig._();
  static final String baseUrl = dotenv.get('BASE_URL', fallback: null);
}
