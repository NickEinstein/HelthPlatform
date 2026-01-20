import '../../../../model/user_model.dart';
import '../../../../provider/all_providers.dart';
import '../../../../utils/packages.dart';

class HomeDrawer extends ConsumerStatefulWidget {
  const HomeDrawer({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends ConsumerState<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);
    final userAsync = ref.watch(userProvider);

    return Drawer(
      backgroundColor: ColorConstant.primaryColor,
      child: Column(
        children: [
          (MediaQuery.paddingOf(context).top).gap,
          const BackButton(color: Colors.white).alignRight,
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 39),
              children: [
                // ✅ Only this part is reactive
                _buildUserHeader(userAsync),
                44.gap,
                const Divider(color: Colors.white),
                _tile(
                  onTap: () => context.pushReplacement(Routes.BOTTOMNAV),
                  title: 'Home',
                ),
                const Divider(color: Colors.white),
                _tile(
                  onTap: () {
                    Navigator.pop(context);
                    context.push(Routes.APPOINTMENT, extra: true);
                  },
                  title: 'Appointment',
                ),
                const Divider(color: Colors.white),
                _tile(
                  onTap: () {
                    Navigator.pop(context);
                    context.push(Routes.PRESCRIPTION, extra: true);
                  },
                  title: 'Prescriptions',
                ),
                const Divider(color: Colors.white),
                _tile(
                  onTap: () {
                    Navigator.pop(context);
                    context.push(Routes.MAINHEALTHGOAL);
                  },
                  title: 'My Health Record',
                ),
                const Divider(color: Colors.white),
                _tile(
                  onTap: () {
                    Navigator.pop(context);
                    context.push(Routes.BILLINGPAGE);
                  },
                  title: 'Billing History',
                ),
                const Divider(color: Colors.white),
                // _tile(
                //   onTap: () {
                //     Navigator.pop(context);
                //     context.push(Routes.HMO);
                //   },
                //   title: 'HMO',
                // ),
                // const Divider(color: Colors.white),
                _tile(
                  onTap: () {
                    Navigator.pop(context);
                    context.push(Routes.USERPERSONAL);
                  },
                  title: 'Personal Records',
                ),
                const Divider(color: Colors.white),
                // _tile(
                //   onTap: () {
                //     Navigator.pop(context);
                //     CustomToast.show(context, "Coming soon...",
                //         type: ToastType.error);
                //   },
                //   title: 'Settings Insurance',
                // ),
                // const Divider(color: Colors.white),
                _tile(
                  onTap: () async {
                    await authService.logout();
                    if (context.mounted) {
                      context.pushReplacement(Routes.SIGNIN);
                      CustomToast.show(
                        context,
                        "Logout successfully...",
                        type: ToastType.success,
                      );
                    }
                  },
                  title: 'Log Out',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserHeader(AsyncValue<UserData> userAsync) {
    return userAsync.when(
      data: (user) {
        final imageUrl = user.pictureUrl!.contains('https')
            ? user.pictureUrl!
            : user.pictureUrl!.contains('/UploadedFiles')
                ? '${AppConstants.noSlashImageURL}${user.pictureUrl!}'
                : '${AppConstants.noSlashImageURL}/${user.pictureUrl!}';
        final initials = '${user.firstName![0]}${user.lastName![0]}';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.network(
                imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      getAvatarColor(user.firstName! + user.lastName!),
                  child: Text(initials,
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
            20.gap,
            Text(
              '${user.firstName!} ${user.lastName!}',
              style: const TextStyle(
                color: Color(0xFF36FF3E),
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: SizedBox()),
      error: (_, __) => const Text('User info unavailable',
          style: TextStyle(color: Colors.white)),
    );
  }

  Widget _tile({required VoidCallback onTap, required String title}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
