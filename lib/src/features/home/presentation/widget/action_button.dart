import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/routes/routes.dart';

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
        "title": "Doctors",
        "icon": "assets/icon/doctor.png",
        "onTap": () => context.push(Routes.DOCTORPAGE),
      },
      {
        "title": "Pharmacy",
        "icon": "assets/icon/phermacy.png",
        "onTap": () => context.push(Routes.CAREGIVERSPAGE, extra: 'Pharmacy'),
      },
      {
        "title": "Caregiver",
        "icon": "assets/icon/caregive.png",
        "onTap": () => context.push(Routes.CAREGIVERSPAGE, extra: 'Caregivers'),
      },
      {
        "title": "Community",
        "icon": "assets/icon/community.png",
        "onTap": () => context.push(Routes.MYCOMMUNITY),
      },
      {
        "title": "Book",
        "icon": "assets/icon/book.png",
        "onTap": () => context.push(Routes.DOCTORPAGE),
      },
      {
        "title": "Lab",
        "icon": "assets/icon/phermacy.png",
        "onTap": () => context.push(Routes.CAREGIVERSPAGE, extra: 'Lab'),
      },
      {
        "title": "Hospital",
        "icon": "assets/icon/phermacy.png",
        "onTap": () => context.push(Routes.CAREGIVERSPAGE, extra: 'Hospital'),
      },
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What will you like to do today?",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff444444),
          ),
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
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
                color: Color(color), borderRadius: BorderRadius.circular(50)),
            child: Column(
              children: [
                Image.asset(
                  icon,
                  width: 25,
                  height: 25,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(title,
            style: const TextStyle(
                color: Color(0xff091F44),
                fontSize: 14,
                fontWeight: FontWeight.w400))
      ],
    );
  }
}
