import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/features/prescription/models/get_prescriptions_model.dart';
import 'package:greenzone_medical/src/routes/app_pages.dart';
import 'package:greenzone_medical/src/utils/custom_header.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class PrescriptionItem {
  final String name;
  final String pharmacy;
  final int? quantity;
  final int? freqPerDay;
  final int? durationDays;

  const PrescriptionItem({
    required this.name,
    required this.pharmacy,
    this.quantity,
    this.freqPerDay,
    this.durationDays,
  });
}

class PrescriptionDetailsPage extends StatelessWidget {
  final Prescription prescription;
  const PrescriptionDetailsPage({super.key, required this.prescription});

  final _items = const [
    PrescriptionItem(
      name: 'McMayer Paracetamol 500mg',
      pharmacy: 'MedPlus, Aboyade Cole Street, Victoria Island.',
    ),
    PrescriptionItem(
      name: 'McMayer Paracetamol 500mg',
      pharmacy: 'MedPlus, Aboyade Cole Street, Victoria Island.',
    ),
    PrescriptionItem(
      name: 'McMayer Paracetamol 500mg',
      pharmacy: 'HealthLand, Awolowo Road, Ikoyi, Lagos',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,

              // ── Header ──────────────────────────────────────────────────
              CustomHeader(
                title: 'Prescription Log',
                onPressed: () => Navigator.pop(context),
              ),

              20.height,

              // ── Pharmacy card ────────────────────────────────────────────
              _PharmacyCard(items: _items, prescription: prescription),

              20.height,

              // ── Table ────────────────────────────────────────────────────
              _PrescriptionTable(items: _items),

              16.height,

              const _AdditionalNoteBox(),

              20.height,

              Center(
                child: InkWell(
                  onTap: () {
                    context.push(
                      Routes.DOCTORRATINGPAGE,
                      extra: {
                        'doctorId': prescription.doctorId,
                        'doctorName': prescription.doctor,
                      },
                    );
                  },
                  child: Text(
                    'Rate your experience with Dr. ${prescription.doctor ?? 'Wynn'}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ),

              24.height,
            ],
          ),
        ),
      ),
    );
  }
}


// ─── Pharmacy pick-up card ────────────────────────────────────────────────────
class _PharmacyCard extends StatelessWidget {
  final List<PrescriptionItem> items;
  final Prescription prescription;

  const _PharmacyCard({required this.items, required this.prescription});

  static const _green = Color(0xFF4CAF50);
  static const _lightGreen = Color(0xFFE8F5E9);
  static const _borderGreen = Color(0xFFA5D6A7);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderGreen),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Text(
              'Prescription for ${prescription.diagnosis ?? 'Persistent Headache'}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
            child: Text(
              "Here's a list of items you need to pick up:",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ),

          // Items
          ...items.map((item) => _PharmacyItemRow(item: item)),

          // Cost row
          Container(
            decoration: const BoxDecoration(
              color: _lightGreen,
              border: Border(top: BorderSide(color: _borderGreen)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: const Row(
              children: [
                Text(
                  'Med. Cost: ',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                Text(
                  'N15,250.00',
                  style: TextStyle(
                    fontSize: 12,
                    color: _green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  '  |  HMO Cover: ',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const Text(
                  'N15,250.00',
                  style: TextStyle(
                    fontSize: 12,
                    color: _green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Contribution
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: _borderGreen)),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: const Center(
              child: Text(
                'Your Contribution: N0.00',
                style: TextStyle(
                  fontSize: 13,
                  color: _green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PharmacyItemRow extends StatelessWidget {
  final PrescriptionItem item;

  const _PharmacyItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                4.height,
                Text(
                  item.pharmacy,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.shopping_bag_outlined,
              color: Color(0xFF4CAF50), size: 20),
        ],
      ),
    );
  }
}

// ─── Prescription table ───────────────────────────────────────────────────────
class _PrescriptionTable extends StatelessWidget {
  final List<PrescriptionItem> items;

  const _PrescriptionTable({required this.items});

  static const _headerGreen = Color(0xFFB9F0BC);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Table(
        border: TableBorder(
          horizontalInside: BorderSide(color: Colors.grey.shade200, width: 0.8),
          verticalInside: BorderSide(color: Colors.grey.shade200, width: 0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        columnWidths: const {
          0: FixedColumnWidth(36),
          1: FlexColumnWidth(),
          2: FixedColumnWidth(62),
          3: FixedColumnWidth(62),
          4: FixedColumnWidth(62),
        },
        children: [
          // Header row
          TableRow(
            decoration: const BoxDecoration(
              color: _headerGreen,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            children: [
              _headerCell('S/n'),
              _headerCell('Name'),
              _headerCell('Quantity'),
              _headerCell('Freq/Day'),
              _headerCell('Duration\n(Days)'),
            ],
          ),
          // Data rows
          ...items.asMap().entries.map((e) {
            final index = e.key;
            final item = e.value;
            return TableRow(
              children: [
                _dataCell('${index + 1}', center: true),
                _dataCell(item.name),
                _dataCell(item.quantity?.toString() ?? '', center: true),
                _dataCell(item.freqPerDay?.toString() ?? '', center: true),
                _dataCell(item.durationDays?.toString() ?? '', center: true),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _headerCell(String text) => TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2E7D32),
            ),
          ),
        ),
      );

  Widget _dataCell(String text, {bool center = false}) => TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Text(
            text,
            textAlign: center ? TextAlign.center : TextAlign.start,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ),
      );
}

// ─── Additional Note box ──────────────────────────────────────────────────────
class _AdditionalNoteBox extends StatelessWidget {
  const _AdditionalNoteBox();

  static const _lightGreen = Color(0xFFE8F5E9);
  static const _borderGreen = Color(0xFFA5D6A7);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _borderGreen),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: _lightGreen,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              border: Border(bottom: BorderSide(color: _borderGreen)),
            ),
            child: const Text(
              'Additional Note',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2E7D32),
              ),
            ),
          ),
          // Body (empty note area)
          const SizedBox(
            height: 100,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(8),
              ),
              minLines: 4,
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}
