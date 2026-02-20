import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

const _lightGreen = Color(0xFFE8F5E9);

class CurrentMedRecord {
  final String date;
  final String time;
  final String prescribedBy;
  final List<String> prescriptions;
  final String location;

  const CurrentMedRecord({
    required this.date,
    required this.time,
    required this.prescribedBy,
    required this.prescriptions,
    required this.location,
  });
}

// ─── Sample Data ──────────────────────────────────────────────────────────────
const _medRecords = [
  CurrentMedRecord(
    date: 'April 18, 2025',
    time: '12.30pm',
    prescribedBy: 'Dr. Wellness',
    prescriptions: [
      'McMayer Paracetamol 500mg',
      'Vitamin C',
      'Tylenol®/acetaminophen',
      'Ferros Iron',
    ],
    location: 'Lifeline Medical Diagnostic Centre, Ilupeju',
  ),
  CurrentMedRecord(
    date: 'April 18, 2025',
    time: '12.30pm',
    prescribedBy: 'Dr. Wellness',
    prescriptions: [
      'McMayer Paracetamol 500mg',
      'Vitamin C',
      'Tylenol®/acetaminophen',
      'Ferros Iron',
    ],
    location: 'Lifeline Medical Diagnostic Centre, Ilupeju',
  ),
];

// ─── Current Meds Tab ─────────────────────────────────────────────────────────
/// Drop into your TabBarView as the third child:
///   TabBarView(
///     controller: _tabController,
///     children: [
///       TestStatisticsTab(),
///       VitalHistoryTab(),
///       CurrentMedsTab(),   // <-- here
///     ],
///   )
class CurrentMedsTab extends StatelessWidget {
  const CurrentMedsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      itemCount: _medRecords.length,
      separatorBuilder: (_, __) => 16.height,
      itemBuilder: (context, i) => _MedCard(record: _medRecords[i]),
    );
  }
}

// ─── Med Card ─────────────────────────────────────────────────────────────────
class _MedCard extends StatelessWidget {
  final CurrentMedRecord record;

  const _MedCard({required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Green date/time header ───────────────────────────────────
          _MedCardHeader(date: record.date, time: record.time),

          // ── Prescribed by ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 13),
                children: [
                  const TextSpan(
                    text: 'Prescribed by: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  TextSpan(
                    text: record.prescribedBy,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),

          const _Divider(),

          // ── Prescription list ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
            child: _PrescriptionList(items: record.prescriptions),
          ),

          const _Divider(),

          // ── Location ─────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: _LocationBlock(location: record.location),
          ),
        ],
      ),
    );
  }
}

// ─── Card Header ─────────────────────────────────────────────────────────────
class _MedCardHeader extends StatelessWidget {
  final String date;
  final String time;

  const _MedCardHeader({required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        color: _lightGreen,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Text(
            date,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '|',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            ),
          ),
          Text(
            time,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, size: 18, color: Colors.black45),
        ],
      ),
    );
  }
}

// ─── Prescription list ────────────────────────────────────────────────────────
class _PrescriptionList extends StatelessWidget {
  final List<String> items;

  const _PrescriptionList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Prescription',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        10.height,
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Location block ───────────────────────────────────────────────────────────
class _LocationBlock extends StatelessWidget {
  final String location;

  const _LocationBlock({required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        6.height,
        Text(
          location,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}

// ─── Reusable section divider ─────────────────────────────────────────────────
class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
    );
  }
}
