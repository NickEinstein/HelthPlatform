import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/features/plan/models/specialist_model.dart';
import 'package:greenzone_medical/src/provider/all_providers.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';
import 'package:greenzone_medical/src/utils/loading_widget.dart';

class SpecialistTab extends ConsumerWidget {
  const SpecialistTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specialistList = ref.watch(specialistListProvider);

    return SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: specialistList.when(
          data: (specialistList) => ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: specialistList.length,
            itemBuilder: (context, index) {
              final specialist = specialistList[index];
              return _buildSpecialistCard(
                context,
                specialist: specialist,
              );
            },
          ),
          error: (_, e) =>  SizedBox(
            child: Text(e.toString()),
          ),
          loading: () => const ListLoader(),
        ));
  }
}

Widget _buildSpecialistCard(
  BuildContext context, {
  required SpecialistModel specialist,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: const Color(0xFFF9F9F9), // Light grey background
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
                // image: DecorationImage(
                //   image: CachedNetworkImageProvider(specialist.i),
                //   fit: BoxFit.cover,
                //   onError: (exception, stackTrace) {},
                // ),
              ),
            ),
            15.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    specialist.name,
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  5.height,
                  Text(
                    specialist.description,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade700,
                      fontSize: 11,
                    ),
                  ),
                  8.height,
                  Row(
                    children: [
                      const Icon(Icons.store, size: 14, color: Colors.green),
                      5.width,
                      Text(
                        '',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade700,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        15.height,
        const Divider(height: 1, color: Colors.grey),
        10.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSocialIcon(Icons.phone, filled: true),
            _buildSocialIcon(Icons.email_outlined),
            _buildSocialIcon(Icons.camera_alt_outlined), // Instagram
            _buildSocialIcon(Icons.location_on_outlined),
            _buildSocialIcon(Icons.music_note), // TikTok
          ],
        ),
      ],
    ),
  );
}

Widget _buildSocialIcon(IconData icon, {bool filled = false}) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: filled ? const Color(0xFF109615) : Colors.transparent,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
        color: const Color(0xFF109615),
      ),
    ),
    child: Icon(
      icon,
      size: 18,
      color: filled ? Colors.white : const Color(0xFF109615),
    ),
  );
}
