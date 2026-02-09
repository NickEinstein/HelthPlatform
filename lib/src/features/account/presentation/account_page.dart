// ignore_for_file: use_build_context_synchronously

import 'package:intl/intl.dart';

import '../../../model/user_model.dart';
import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);
    final userAsync = ref.watch(userProvider);

    return FutureBuilder<LoginResponse?>(
      future: authService.getStoredUser(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false, // Removes default back button
            centerTitle: false, // Aligns title to the left
            title: Row(
              children: [
                InkWell(
                  onTap: () {
                    widget.scaffoldKey.currentState
                        ?.openEndDrawer(); // 👈 open left drawer
                  },
                  child: const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.menu,
                        color: Color(0xff262527),
                        size: 22,
                      )

                      //  Image.asset(
                      //   "assets/icon/menu.png",
                      //   height: 23,
                      //   width: 37,
                      // ),
                      ),
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Account Settings',
                        style: TextStyle(
                          color: Color(0xff262527),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // TextSpan(
                      //   text: '\n$userName',
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 14,
                      //     height: 1.9,
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
                vertical: 5), // remove horizontal padding
            child: Center(
              // 👈 centers horizontally
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  smallSpace(),
                  _buildUserHeader(userAsync),
                  tinySpace(),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xffD9FEAA),
                        border: Border.all(
                          color: const Color(0xff109615),
                        )),
                    child: const Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 7),
                      child: Text(
                        'Account Active',
                        style: TextStyle(
                            color: Color(0xff109615),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  smallSpace(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xff109615),
                          width: 1.5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icon/coin.png',
                              height: 50,
                              width: 50,
                            ),
                            const Expanded(
                              child: const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'You have earned',
                                      style: TextStyle(
                                          color: Color(0xff878787),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      '0 Coin',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  smallSpace(),
                  LastLoginText(),
                  verticalSpace(context, 0.06),
                  settingsRow(
                    title: 'Billing & Rewards',
                    onTap: () {
                      context.push(Routes.BILLING_REWARDS_PAGE);
                    },
                  ),
                  settingsRow(
                    title: 'Password Reset',
                    onTap: () {
                      context.push(Routes.ACCOUNTRESETPASSWORDPAGE);
                    },
                  ),
                  settingsRow(
                    title: 'Flagged Content',
                    onTap: () {
                      context.push(Routes.FLAGGEDCONTENTPAGE);
                    },
                  ),
                  settingsRow(
                    title: 'View Referrals',
                    onTap: () {
                      context.push(Routes.REFFEREDCONTENTPAGE);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
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
                color: Color(0xFF252525),
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            5.gap,
            Text(
              user.email!,
              style: const TextStyle(
                color: Color(0xFFA7A7A7),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const Text('User info unavailable',
          style: TextStyle(color: Colors.white)),
    );
  }

  Widget settingsRow({
    required String title,
    IconData icon = Icons.add,
    VoidCallback? onTap,
    EdgeInsetsGeometry padding =
        const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 15),
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff616060),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Icon(
                  icon,
                  color: const Color(0xff818181),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

class LastLoginText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('dd.MM.yyyy').format(now);
    final formattedTime = DateFormat('h.mm a').format(now); // e.g., 8.45 PM

    return Text(
      'Last Login: $formattedDate  |  $formattedTime',
      style: const TextStyle(
        color: Color(0xff858585),
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );
  }
}
