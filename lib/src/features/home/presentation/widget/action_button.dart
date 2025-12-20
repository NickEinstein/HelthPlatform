import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/routes/routes.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';

class ActionButtonsRow extends StatefulWidget {
  const ActionButtonsRow({super.key});

  @override
  State<ActionButtonsRow> createState() => _ActionButtonsRowState();
}

class _ActionButtonsRowState extends State<ActionButtonsRow> {
  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "title": "Doctor",
        "icon": "assets/icon/doctor.png",
        "onTap": () => context.push(Routes.DOCTORPAGE),
      },
      {
        "title": "Pharmacy",
        "icon": "assets/icon/pharmacy.png",
        "onTap": () => context.push(Routes.CAREGIVERSPAGE, extra: 'Pharmacy'),
      },
      {
        "title": "Lab",
        "icon": "assets/icon/lab.png",
        "onTap": () => context.push(Routes.CAREGIVERSPAGE, extra: 'Lab'),
      },
      {
        "title": "Hospitals",
        "icon": "assets/icon/hospital.png",
        "onTap": () => context.push(Routes.CAREGIVERSPAGE, extra: 'Hospital'),
      },
      {
        "title": "Ambulance",
        "icon": "assets/icon/ambulance.png",
        "onTap": () => context.push(Routes.CAREGIVERSPAGE, extra: 'Caregivers'),
      },
      {
        "title": "Wallet",
        "icon": "assets/icon/wallet.png",
        "onTap": () => context.push(Routes.CAREGIVERSPAGE, extra: 'Caregivers'),
      },
      {
        "title": "Socials",
        "icon": "assets/icon/socials.png",
        "onTap": () => context.push(Routes.MYCOMMUNITY),
      },
      {
        "title": "App Library",
        "icon": "assets/icon/applibrary.png",
        "onTap": () => context.push(Routes.MYCOMMUNITY),
      },
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What will you like to do today?",
          style: context.textTheme.labelLarge,
        ),
        smallSpace(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(items.length, (index) {
              final item = items[index];
              return Row(
                children: [
                  ActionButton(
                    title: item["title"] as String,
                    icon: item["icon"] as String,
                    onButtonPressed: item["onTap"] as VoidCallback,
                    color: 0xffEAFFEB,
                  )
                      .animate()
                      .slideX(begin: 1, end: 0, duration: 400.ms)
                      .fadeIn(delay: (index * 100).ms), // delay based on index
                  smallHorSpace(),
                ],
              );
            }),
          ),
        )
      ],
    );
  }
}

// Action Button Widget
class ActionButton extends StatelessWidget {
  final String title;
  final String icon;
  final int color;
  final VoidCallback onButtonPressed;

  const ActionButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onButtonPressed,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onButtonPressed,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff109615)),
                color: Color(color),
                borderRadius: BorderRadius.circular(50)),
            child: Column(
              children: [
                Image.asset(
                  icon,
                  width: 35,
                  height: 35,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(title,
            style: const TextStyle(
                color: Color(0xff091F44),
                fontSize: 13,
                fontWeight: FontWeight.w400))
      ],
    );
  }
}
