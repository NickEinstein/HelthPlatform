import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

const _lightGreen = Color(0xFFE8F5E9);

class VitalRecord {
  final String date;
  final String time;
  final Map<String, String> vitals;
  final List<String> notes;
  final String location;
  final String administrator;

  const VitalRecord({
    required this.date,
    required this.time,
    required this.vitals,
    required this.notes,
    required this.location,
    required this.administrator,
  });
}

const _vitalRecords = [
  VitalRecord(
    date: 'April 18, 2025',
    time: '12.30pm',
    vitals: {
      'Blood Pressure:': '128/78 mmHg',
      'Heart Rate (Pulse):': '72 beats per minute (bpm)',
      'Respiratory Rate:': '16 breaths per minute',
      'Body Temperature:': '98.6°F (37°C)',
      'Oxygen Sat(SpO2):': '98%',
      'Height': '180 cm (5 ft 11 in)',
      'Weight:': '85 kg (187 lbs)',
      'Body Mass Index:': '26.2 (Overweight)',
    },
    notes: [
      'Patient appears well and reports feeling fine.',
      'No complaints of dizziness, shortness of breath, or chest pain.',
    ],
    location: 'Lifeline Medical Diagnostic Centre, Ilupeju',
    administrator: 'Nurse Wellness',
  ),
  VitalRecord(
    date: 'April 18, 2025',
    time: '12.30pm',
    vitals: {
      'Blood Pressure:': '128/78 mmHg',
      'Heart Rate (Pulse):': '72 beats per minute (bpm)',
      'Respiratory Rate:': '16 breaths per minute',
      'Body Temperature:': '98.6°F (37°C)',
      'Oxygen Sat(SpO2):': '98%',
      'Height': '180 cm (5 ft 11 in)',
    },
    notes: [],
    location: '',
    administrator: '',
  ),
];

class VitalHistoryTab extends StatelessWidget {
  final List<String> vitalHistory;
  const VitalHistoryTab({super.key, required this.vitalHistory});

  @override
  Widget build(BuildContext context) {
    return vitalHistory.isEmpty
        ? Center(
            child: Text(
              'No records found',
              style: context.textTheme.bodyLarge,
            ),
          )
        : ListView.separated(
            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: _vitalRecords.length,
            separatorBuilder: (_, __) => 16.height,
            itemBuilder: (context, i) => _VitalCard(record: _vitalRecords[i]),
          );
  }
}

// ─── Vital Card ───────────────────────────────────────────────────────────────
class _VitalCard extends StatelessWidget {
  final VitalRecord record;

  const _VitalCard({required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Green header ─────────────────────────────────────────────
          _VitalCardHeader(date: record.date, time: record.time),

          // ── Vitals list ──────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            child: Column(
              children: record.vitals.entries
                  .map((e) => _VitalRow(label: e.key, value: e.value))
                  .toList(),
            ),
          ),

          // ── Additional Notes ─────────────────────────────────────────
          if (record.notes.isNotEmpty) ...[
            12.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: _AdditionalNotes(notes: record.notes),
            ),
          ],

          // ── Location block ───────────────────────────────────────────
          if (record.location.isNotEmpty) ...[
            12.height,
            const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: _LocationBlock(
                location: record.location,
                administrator: record.administrator,
              ),
            ),
          ] else ...[
            14.height,
          ],
        ],
      ),
    );
  }
}

// ─── Card Header ─────────────────────────────────────────────────────────────
class _VitalCardHeader extends StatelessWidget {
  final String date;
  final String time;

  const _VitalCardHeader({required this.date, required this.time});

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
          const Text(
            'Vitals',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          12.width,
          Text(
            date,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '|',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            ),
          ),
          Text(
            time,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, size: 18, color: Colors.black45),
        ],
      ),
    );
  }
}

// ─── Single vital row ─────────────────────────────────────────────────────────
class _VitalRow extends StatelessWidget {
  final String label;
  final String value;

  const _VitalRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Additional Notes ─────────────────────────────────────────────────────────
class _AdditionalNotes extends StatelessWidget {
  final List<String> notes;

  const _AdditionalNotes({required this.notes});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Notes:',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        8.height,
        ...notes.map(
          (note) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '• ',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                Expanded(
                  child: Text(
                    note,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.black54, height: 1.4),
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

// ─── Location Block ───────────────────────────────────────────────────────────
class _LocationBlock extends StatelessWidget {
  final String location;
  final String administrator;

  const _LocationBlock({
    required this.location,
    required this.administrator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
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
          10.height,
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 13),
              children: [
                const TextSpan(
                  text: 'Administrator: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                TextSpan(
                  text: administrator,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
