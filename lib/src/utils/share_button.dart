import 'package:share_plus/share_plus.dart';

Future<void> shareContent({
  required String title,
  required String message,
}) async {
  final fullMessage = "$title\n\n$message";
  await Share.share(fullMessage);
}
