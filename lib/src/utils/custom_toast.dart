import 'package:flutter/material.dart';

class CustomToast {
  static void show(BuildContext context, String message,
      {ToastType type = ToastType.success, int durationInSeconds = 2}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50.0,
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Material(
          color: Colors.transparent,
          child: _ToastContent(message: message, type: type),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(Duration(seconds: durationInSeconds), () {
      overlayEntry.remove();
    });
  }
}

enum ToastType { success, warning, error }

class _ToastContent extends StatelessWidget {
  final String message;
  final ToastType type;

  const _ToastContent({required this.message, required this.type});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    IconData icon;

    switch (type) {
      case ToastType.success:
        bgColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case ToastType.warning:
        bgColor = Colors.amber;
        icon = Icons.warning;
        break;
      case ToastType.error:
        bgColor = Colors.red;
        icon = Icons.error;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Flexible(
            // <--- use Flexible instead of Expanded
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              maxLines: 3, // optional: allow up to 3 lines before cutting
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
