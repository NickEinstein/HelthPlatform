import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/utils/custom_header.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

const _green = Color(0xFF4CAF50);
const _lightGreen = Color(0xFFE8F5E9);
const _borderGreen = Color(0xFFA5D6A7);

class DoctorsReferralRequestPage extends StatelessWidget {
  const DoctorsReferralRequestPage({super.key});

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
              20.height,

              // ── Header ──────────────────────────────────────────────────
              CustomHeader(
                title: "Doctor's Referral Request",
                onPressed: () => Navigator.pop(context),
              ),

              24.height,

              // ── Pharmacy Card ────────────────────────────────────────────
              const _PharmacyCard(),

              20.height,

              // ── Cost Table ───────────────────────────────────────────────
              const _CostTable(),

              24.height,

              // ── Contact Details ──────────────────────────────────────────
              const _ContactDetails(),

              30.height,
            ],
          ),
        ),
      ),
    );
  }
}

class _PharmacyCard extends StatelessWidget {
  const _PharmacyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Search / ID field with arrow ──────────────────────────────
          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: _lightGreen,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: _borderGreen),
                  ),
                  child: const Text(
                    '•••••••',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              12.width,
              const Icon(
                Icons.chevron_right,
                color: Colors.black45,
                size: 22,
              ),
            ],
          ),

          16.height,

          // ── Pharmacy name & details ───────────────────────────────────
          const Text(
            'MedPlus Pharmacies',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          6.height,

          Row(
            children: [
              Text(
                '9 Egbeyemi Street, Ilupeju, Lagos',
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
                '12km',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),

          8.height,

          // ── Star rating ───────────────────────────────────────────────
          Row(
            children: [
              _StarRating(rating: 4.5),
              8.width,
              Text(
                '4.8 (10 reviews)',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),

          16.height,

          // ── Action icons + logo ───────────────────────────────────────
          Row(
            children: [
              _ActionIconButton(icon: Icons.shopping_cart_outlined),
              10.width,
              _ActionIconButton(icon: Icons.chat_bubble_outline),
              10.width,
              _ActionIconButton(icon: Icons.phone_outlined),
              const Spacer(),
              // Pharmacy logo placeholder
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    '💊',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Star Rating ──────────────────────────────────────────────────────────────
class _StarRating extends StatelessWidget {
  final double rating;

  const _StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = i < rating.floor();
        final half = !filled && i < rating;
        return Icon(
          half ? Icons.star_half : (filled ? Icons.star : Icons.star_border),
          color: const Color(0xFFFFC107),
          size: 16,
        );
      }),
    );
  }
}

// ─── Action Icon Button ───────────────────────────────────────────────────────
class _ActionIconButton extends StatelessWidget {
  final IconData icon;

  const _ActionIconButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: _lightGreen,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _borderGreen),
      ),
      child: Icon(icon, color: _green, size: 20),
    );
  }
}

// ─── Cost Table ───────────────────────────────────────────────────────────────
class _CostTable extends StatelessWidget {
  const _CostTable();

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
          0: FlexColumnWidth(),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
        },
        children: [
          // Header
          TableRow(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            children: [
              _tableCell('Cost', isHeader: true),
              _tableCell('HMO Cover', isHeader: true),
              _tableCell('Balance', isHeader: true),
            ],
          ),
          // Data
          TableRow(
            children: [
              _tableCell('N4,500.00'),
              _tableCell('N4,000.00'),
              _tableCell('N500.00'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tableCell(String text, {bool isHeader = false}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
            color: isHeader ? Colors.black87 : Colors.black54,
          ),
        ),
      ),
    );
  }
}

// ─── Contact Details ──────────────────────────────────────────────────────────
class _ContactDetails extends StatelessWidget {
  const _ContactDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Details',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: _green,
          ),
        ),
        16.height,
        _ContactRow(
          icon: Icons.email_outlined,
          label: 'admin@NHAhospital.com',
        ),
        12.height,
        _ContactRow(
          icon: Icons.phone_outlined,
          label: '+23481-785-253',
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ContactRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _green,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        16.width,
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
