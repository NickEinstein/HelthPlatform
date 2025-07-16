import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../provider/all_providers.dart';
import '../resources/resources.dart';
import '../resources/textstyles/app_textstyles.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final bool allowBackButton;
  final String? title;
  const CustomAppBar({
    super.key,
    this.allowBackButton = false,
    this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showDrawer = Scaffold.maybeOf(context)?.hasDrawer ?? false;
    final userAsync = ref.watch(userProvider);

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          if (showDrawer)
            InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: SvgPicture.asset(SvgAssets.tarBar),
            ),
          if (title != null)
            Expanded(
              child: Text(
                title!,
                style: CustomTextStyle.textbold24.w600,
                textAlign: TextAlign.center,
              ),
            )
          else
            const Spacer(),

          // ✅ Handle loading, error, and data states
          userAsync.when(
            data: (userData) {
              final hasPicture = (userData.pictureUrl?.isNotEmpty ?? false);
              return Container(
                width: 50,
                height: 50,
                decoration: ShapeDecoration(
                  color: const Color(0xFFD9D9D9),
                  shape: const OvalBorder(),
                  image: hasPicture
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(userData.pictureUrl!),
                        )
                      : const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/profimg.png"),
                        ),
                ),
              );
            },
            loading: () => const SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            error: (err, _) => const Icon(Icons.error),
          ),
        ],
      ),
      automaticallyImplyLeading: allowBackButton,
    );
  }
}
