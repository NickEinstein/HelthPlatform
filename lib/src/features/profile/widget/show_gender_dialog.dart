import 'package:greenzone_medical/src/utils/packages.dart';

Future<String?> showGenderDialog(BuildContext context) => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Gender'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                Navigator.pop(context, 'Male');
              },
              title: const Text('Male'),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context, 'Female');
              },
              title: const Text('Female'),
            )
          ],
        ),
      ),
    );
