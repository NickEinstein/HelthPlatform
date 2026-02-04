import 'package:google_cloud_translation/google_cloud_translation.dart';

class CloudTranslateService {
  final Translation _translation;

  CloudTranslateService(String apiKey)
      : _translation = Translation(apiKey: apiKey);

  Future<String> translateText({
    required String text,
    required String to,
  }) async {
    final result = await _translation.translate(
      text: text,
      to: to,
    );
    return result.translatedText;
  }

  Future<String> detectLanguage(String text) async {
    final detection = await _translation.detectLang(text: text);
    return detection.detectedSourceLanguage;
  }
}
