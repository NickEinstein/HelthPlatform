import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/routes/routes.dart';

import '../../../../utils/custom_toast.dart';

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
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
            children: [
              ActionButton(
                title: "Doctors",
                onButtonPressed: () {
                  context.push(Routes.DOCTORPAGE);
                },
                icon: "assets/icon/doctor.png",
                color: 0xffEAFFEB,
              ),
              smallHorSpace(),
              ActionButton(
                title: "Pharmacy",
                onButtonPressed: () {
                  CustomToast.show(context, "Coming soon...",
                      type: ToastType.error);
                },
                icon: "assets/icon/phermacy.png",
                color: 0xffEAFFEB,
              ),
              smallHorSpace(),
              ActionButton(
                title: "Caregiver",
                onButtonPressed: () {
                  context.push(Routes.CAREGIVERSPAGE);
                },
                icon: "assets/icon/caregive.png",
                color: 0xffEAFFEB,
              ),
              smallHorSpace(),
              ActionButton(
                title: "Community",
                onButtonPressed: () {
                  context.push(Routes.COMMUNITYLIST);
                },
                icon: "assets/icon/community.png",
                color: 0xffEAFFEB,
              ),
              smallHorSpace(),
              ActionButton(
                title: "Book",
                onButtonPressed: () {
                  context.push(Routes.COMMUNITYLIST);
                },
                icon: "assets/icon/book.png",
                color: 0xffEAFFEB,
              ),
              smallHorSpace(),
              ActionButton(
                title: "Pay",
                onButtonPressed: () {
                  context.push(Routes.COMMUNITYLIST);
                },
                icon: "assets/icon/doctor.png",
                color: 0xffEAFFEB,
              ),
            ],
          ),
        ),
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
                  width: 32,
                  height: 32,
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
