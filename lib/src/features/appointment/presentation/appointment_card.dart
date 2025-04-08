import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String imageUrl;
  final String doctorName;
  final String treatment;
  final String date;
  final String time;
  final String buttonText1;
  final String buttonText2;
  final VoidCallback onCancel;
  final VoidCallback onReschedule;
  final bool showCancelButton;
  final bool buttonsDisabled;

  const AppointmentCard({
    super.key,
    required this.imageUrl,
    required this.doctorName,
    required this.treatment,
    required this.date,
    required this.time,
    required this.buttonText1,
    required this.buttonText2,
    required this.onCancel,
    required this.onReschedule,
    this.showCancelButton = true,
    this.buttonsDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctorName,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        treatment,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 14, color: Colors.green),
                          const SizedBox(width: 4),
                          Text(date, style: const TextStyle(fontSize: 11)),
                          const SizedBox(width: 8),
                          const Icon(Icons.access_time,
                              size: 14, color: Colors.green),
                          const SizedBox(width: 4),
                          Text(time, style: const TextStyle(fontSize: 11)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (showCancelButton)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: buttonsDisabled ? null : onCancel,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green),
                      ),
                      child: Text(
                        buttonText1,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                if (showCancelButton) const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: buttonsDisabled ? null : onReschedule,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      buttonText2,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
