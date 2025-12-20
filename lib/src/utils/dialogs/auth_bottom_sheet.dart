// ignore_for_file: use_build_context_synchronously

import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/primary_button.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

Future<void> showAuthBottomSheet(
  BuildContext context, {
  required String nextRoute,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: context.viewInsets.bottom),
      child: AuthDialog(nextRoute: nextRoute),
    ),
  );
}

class AuthDialog extends ConsumerStatefulWidget {
  final String nextRoute;
  const AuthDialog({super.key, required this.nextRoute});

  @override
  ConsumerState<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends ConsumerState<AuthDialog> {
  late TextEditingController _passwordController;
  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            36.height,
            Image.asset('assets/icon/hego.png', height: 53, width: 53),
            16.height,
            Text(
              'Personal Health Record Access',
              style: context.textTheme.labelLarge?.copyWith(fontSize: 18),
            ),
            16.height,
            Text(
              'You are about to access a very sensitive data and your password is required for authentication.',
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            16.height,
            LoginPasswordTextField(
                label: 'Password', controller: _passwordController),
            // CustomTextField(
            //   label: 'Password',
            //   controller: _passwordController,
            //   obscureText: true,
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please enter your password';
            //     }
            //     return null;
            //   },
            // ),
            30.height,
            AppButton(
              onPressed: () async {
                final isValid = await ref
                    .read(authServiceProvider)
                    .authenticateUserLocally(_passwordController.text);
                if (mounted) {
                  if (isValid) {
                    context.pop();
                    context.push(widget.nextRoute);
                  } else {
                    context.showFeedBackDialog(
                      message: 'Wrong password',
                      toastType: ToastType.error,
                    );
                    context.pop();
                  }
                }
              },
              child: const Text('Proceed'),
            ),
            (context.padding.bottom + 20).height,
          ],
        ),
      ),
    );
  }
}
