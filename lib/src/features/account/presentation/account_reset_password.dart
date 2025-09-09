import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../constants/helper.dart';
import '../../../provider/all_providers.dart';
import '../../../routes/routes.dart';
import '../../../utils/custom_header.dart';
import '../../../utils/custom_toast.dart';
import '../../../utils/dialogs/dialog.dart';

class AccountResetPasswordPage extends ConsumerStatefulWidget {
  AccountResetPasswordPage({
    super.key,
  });

  @override
  ConsumerState<AccountResetPasswordPage> createState() =>
      _AccountResetPasswordPageState();
}

class _AccountResetPasswordPageState
    extends ConsumerState<AccountResetPasswordPage> {
  String oldPassword = "";

  String password = "";
  String confirmPassword = "";
  String fullname = '';
  String userEmail = '';

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _passwordsMatch = false;
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;

  void _validateForm() {
    setState(() {
      _isValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);
    final userAsync = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: Colors.white, // Matching the UI
      body: Form(
        key: _formKey,
        onChanged: _validateForm,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Page Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomHeader(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        title: 'Password Reset',
                      ),
                      userAsync.when(
                        data: (user) {
                          final imageUrl = user.pictureUrl!.contains('https')
                              ? user.pictureUrl!
                              : user.pictureUrl!.contains('/UploadedFiles')
                                  ? '${AppConstants.noSlashImageURL}${user.pictureUrl!}'
                                  : '${AppConstants.noSlashImageURL}/${user.pictureUrl!}';
                          final initials =
                              '${user.firstName![0]}${user.lastName![0]}';
                          fullname = user.firstName!;
                          userEmail = user.email!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipOval(
                                child: Image.network(
                                  imageUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => CircleAvatar(
                                    radius: 20,
                                    backgroundColor: getAvatarColor(
                                        user.firstName! + user.lastName!),
                                    child: Text(initials,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        loading: () => const CircularProgressIndicator(),
                        error: (_, __) => const Text('User info unavailable',
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),

                  mediumSpace(),
                  OldPasswordTextField(
                    label: "Enter your old password",
                    onChanged: (value) {
                      setState(() {
                        oldPassword = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  PasswordTextField(
                    label: "Enter new password",
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ConfirmPasswordTextField(
                    label: "Enter confirm password",
                    password: password, // ✅ This now updates dynamically
                    onMatchChanged: (isMatching) {
                      _passwordsMatch = isMatching;
                    },
                    controller: _confirmPasswordController,
                  ),

                  // ConfirmPasswordTextField(
                  //   label: "Confirm Password",
                  //   password: _confirmPasswordController.text,
                  //   onMatchChanged: (isMatching) {
                  //     setState(() {
                  //       _passwordsMatch = isMatching;
                  //     });
                  //   },
                  // ),
                  // ConfirmPasswordTextField(
                  //   label: "Confirm Password",
                  //   password: password,
                  // ),

                  mediumSpace(),
                  smallSpace(),

                  // PageView for Steps
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.primaryColor,
                            foregroundColor: ColorConstant.primaryColor,
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            // context.push(Routes.OTPPAGE);
                            if (canProceed(password,
                                    _confirmPasswordController.text) &&
                                _passwordsMatch &&
                                _confirmPasswordController.text.isNotEmpty &&
                                password.isNotEmpty) {
                              ref.read(isLoadingProvider.notifier).state = true;

                              final authService = ref.read(authServiceProvider);

                              if (_formKey.currentState!.validate()) {
                                final email = userEmail;

                                final result =
                                    await authService.resetPasswordUrl(
                                        email, oldPassword, password);

                                if (!context.mounted)
                                  return; // ✅ Prevents using context if unmounted
                                ref.read(isLoadingProvider.notifier).state =
                                    false;

                                if (result == 'successful') {
                                  showInfoBottomSheet(
                                    context,
                                    'Hello $fullname, good news!',
                                    'Your password has been successfully reset.',
                                    buttonText: 'Continue',
                                    isAnotherTime: false,
                                    onPressed: () async {
                                      Navigator.pop(context);

                                      context.pushReplacement(Routes.BOTTOMNAV);
                                    },
                                  );
                                } else {
                                  CustomToast.show(context, result,
                                      type: ToastType.error);
                                }
                              }
                            } else {
                              CustomToast.show(
                                  context, 'Kindly Check password strength',
                                  type: ToastType.error);
                            }
                          },
                          child: const Text(
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.white),
                              "Continue"),
                        ),
                  smallSpace(),

                  // Navigation Buttons
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
