import 'package:flutter/material.dart';

class DoctorsReportDetails extends StatelessWidget {
  const DoctorsReportDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Respiratory Infection',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF17631A),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.medical_services, color: Colors.green),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Respiratory Infection',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 12, color: Colors.white70),
                          const SizedBox(width: 4),
                          const Text('15 Mar 2025',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 12)),
                          const SizedBox(width: 10),
                          const Icon(Icons.access_time,
                              size: 12, color: Colors.white70),
                          const SizedBox(width: 4),
                          const Text('20:00 PM',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 12)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            ...['Vitals', 'Diagnosis & Treatment', 'Prescription', 'Lab Services', 'Discharge Note'].map((item) {
              return ExpansionTile(
                title: Text(item,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                collapsedBackgroundColor: Colors.green.shade50,
                backgroundColor: Colors.green.shade50,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Detailed information about $item'),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
