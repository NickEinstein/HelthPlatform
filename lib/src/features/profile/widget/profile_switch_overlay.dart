import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/features/profile/presentation/update_contact_details.dart';
import 'package:greenzone_medical/src/features/profile/presentation/update_emergency_contact.dart';
import 'package:greenzone_medical/src/features/profile/presentation/update_personal_info_screen.dart';

OverlayEntry profileSwitchOverlay({
  required LayerLink layerLink,
  required String currentScreen,
  required VoidCallback hideOverlay,
  List<String>? list,
  String? nextRoute,
}) {
  final appList = list ??
      ['Personal Data', 'Contact Details', 'Emergency Contact']
          .where((e) => e != currentScreen)
          .toList();
  Map<String, String> route = {
    'Personal Data': UpdatePersonalDetailsScreen.routeName,
    'Contact Details': UpdateContactDetailsScreen.routeName,
    'Emergency Contact': UpdateEmergencyContact.routeName,
  };
  return OverlayEntry(
    builder: (context) => GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: hideOverlay, // Hide when tapping anywhere
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(color: Colors.transparent),
          ),
          Positioned(
            child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 80),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  // padding: const EdgeInsets.all(12),
                  constraints: const BoxConstraints(maxWidth: 250),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    // border: Border.all(
                    //   color: const Color(0xFF888888),
                    //   width: .76,
                    // ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      appList.length,
                      (index) {
                        return InkWell(
                          onTap: () {
                            final singleRoute =
                                nextRoute ?? route[appList[index]];
                            if (singleRoute != null) {
                              context.pushReplacement(singleRoute);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 12.0,
                            ),
                            child: Text(
                              appList[index],
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
