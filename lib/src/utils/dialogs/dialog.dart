/// The above class provides methods to show loading dialogs and snackbars with different types of
/// messages in a Flutter app.
library;

import '../../routes/old_routes.dart';
import '../packages.dart';

class Dialogs {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void showLoadingDialog() {
    final context = navigatorKey.currentState?.context;
    if (context == null) return; // Prevent null context crash

    showDialog(
      context: context,
      barrierColor: Colors.black
          .withValues(alpha: 0.5), // Full-screen semi-transparent overlay
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  static void pop<T>([T? value]) {
    //log('Pop to [${}]');

    return Navigator.pop(navigatorKey.currentState!.context, value);
  }

  static void hideLoadingDialog() {
    if (navigatorKey.currentState?.overlay?.context != null) {
      Navigator.of(navigatorKey.currentState!.overlay!.context).pop();
    }
  }

  static void showErrorSnackbar({
    required String message,
  }) {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void showSnackbar({
    required String message,
  }) {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        // backgroundColor: Colors.red,
      ),
    );
  }

  static void showSuccessSnackbar({
    required String message,
  }) {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  static Future openBottomSheet({
    bool showBar = false,
    List<Widget>? children,
    Widget? child,
  }) {
    return showModalBottomSheet(
      context: NavigationService.navigatorKey.currentState!.context,
      barrierColor: const Color(0x9C009006),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return CustomBottomSheet(
          showBar: showBar,
          children: children,
          child: child,
        );
      },
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  final bool showBar;
  final List<Widget>? children;
  final Widget? child;
  const CustomBottomSheet({
    super.key,
    this.showBar = true,
    this.children,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(),
              if (showBar)
                Container(
                  width: 80,
                  height: 4,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE2E2E2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ).alignCenter,
              if (children != null) ...children!,
              if (child != null) child!,
            ],
          ),
        ),
      ],
    );
  }
}

void showInfoBottomSheet(
  BuildContext context,
  String title,
  String message, {
  String buttonText = 'Close',
  bool isAnotherTime = false,
  VoidCallback? onPressed,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/icon/hego.png', height: 53, width: 53),
              mediumSpace(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff181819),
                  ),
                ),
              ),
              smallSpace(),
              Text(message, textAlign: TextAlign.center),
              mediumSpace(),
              mediumSpace(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: onPressed ?? () => Navigator.pop(context),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (isAnotherTime)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      context.pushReplacement(Routes.BOTTOMNAV);
                    },
                    child: const Text(
                      'I’ll do another time',
                      style: TextStyle(
                          color: Color(0xff999EA2),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
            ],
          ),
        ),
      );
    },
  );
}
