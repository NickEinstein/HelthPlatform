import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/routes/app_pages.dart';
import 'package:greenzone_medical/src/utils/custom_header.dart';

class DoctorsReportPage extends StatelessWidget {
  const DoctorsReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: CustomHeader(
                title: 'Doctors',
                onPressed: () {
                  Navigator.pop(context);
                },
                // onSearchPressed: () {},
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "National Hospital Abuja",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "10 Crescent Close, Yaba, Lagos",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green
                    .shade50, // or your custom color e.g., Color(0x4D17631A)
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Health Center",
                style: TextStyle(color: Colors.green, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: const [
                  ReportTile(
                    title: "Respiratory Infection",
                    date: "15 Mar 2025",
                    time: "20:00 PM",
                  ),
                  ReportTile(
                    title: "Ear Infection",
                    date: "12 Dec 2024",
                    time: "20:00 PM",
                  ),
                  ReportTile(
                    title: "Sexually Transmitted Infection (STIS)",
                    date: "14 Jun 2022",
                    time: "20:00 PM",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportTile extends StatelessWidget {
  final String title;
  final String date;
  final String time;

  const ReportTile({
    super.key,
    required this.title,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(Routes.DOCTORSREPORTDETAILS),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.green.shade50.withValues(alpha: 0.4),
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.shade100,
            ),
            child: const Icon(Icons.medical_services, color: Colors.green),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(date, style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 10),
              const Icon(Icons.access_time, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(time, style: const TextStyle(fontSize: 12)),
            ],
          ),
          trailing:
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
