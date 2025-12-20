import 'package:greenzone_medical/src/utils/packages.dart';

List<String> maritalStatuses = ['Single', 'Married', 'Divorced', 'Widowed'];
Future<String?> showMaritalStatusDialog(BuildContext context) =>
    showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Marital Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: maritalStatuses
              .map((status) => ListTile(
                    onTap: () {
                      Navigator.pop(context, status);
                    },
                    title: Text(status),
                  ))
              .toList(),
        ),
      ),
    );

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
