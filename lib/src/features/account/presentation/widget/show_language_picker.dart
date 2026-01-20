// lib/localization/language_picker_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../provider/all_providers.dart';
import '../../../../utils/app_language.dart';

void showLanguagePicker(BuildContext context, WidgetRef ref) {
  final selectedLang = ref.read(languageProvider);

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          const Text(
            "Select Language",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...languages.map((lang) {
            final isSelected = lang.code == selectedLang;

            return ListTile(
              title: Text(lang.name),
              trailing: isSelected
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.circle_outlined),
              onTap: () {
                ref.read(languageProvider.notifier).state = lang.code;
                Navigator.pop(context);
              },
            );
          }),
          const SizedBox(height: 16),
        ],
      );
    },
  );
}
