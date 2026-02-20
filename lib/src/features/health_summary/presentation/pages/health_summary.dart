import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/features/health_summary/presentation/widget/current_meds_tab.dart';
import 'package:greenzone_medical/src/features/health_summary/presentation/widget/vital_tab.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

// ─── Constants ───────────────────────────────────────────────────────────────
const _green = Color(0xFF4CAF50);
const _lightGreen = Color(0xFFE8F5E9);
const _yellow = Color(0xFFFFC107);
const _borderColor = Color(0xFFE0E0E0);

// ─── Data ────────────────────────────────────────────────────────────────────
const _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

// Green line (Temperature / primary vital)
const _greenLine = [5.0, 10.0, 22.0, 30.0, 38.0, 35.0, 32.0];

// Yellow line (secondary vital)
const _yellowLine = [18.0, 28.0, 15.0, 10.0, 20.0, 25.0, 15.0];

const _vitals = [
  'Temperature',
  'Heart Pulse',
  'Blood Sugar',
  'Blood Pressure',
  'Weight',
  'Height',
  'BMI',
  'Respiratory Role',
  'Oxy. Saturation',
];

// ─── Page ────────────────────────────────────────────────────────────────────
class HealthSummaryPage extends StatefulWidget {
  const HealthSummaryPage({super.key});

  @override
  State<HealthSummaryPage> createState() => _HealthSummaryPageState();
}

class _HealthSummaryPageState extends State<HealthSummaryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedVital = 0;
  String _selectedPeriod = 'Week';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,

              // ── Back button ─────────────────────────────────────────────
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back,
                    color: Colors.black87, size: 22),
              ),

              16.height,

              // ── Title ───────────────────────────────────────────────────
              const Text(
                'Health Summary',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),

              4.height,

              Text(
                'Here is your health monitor',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              ),

              20.height,

              // ── Tabs ────────────────────────────────────────────────────
              _HealthTabs(controller: _tabController),

              24.height,

              Flexible(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Column(
                      children: [
                        // ── Chart card ──────────────────────────────────────────────
                        _VitalChartCard(
                          selectedPeriod: _selectedPeriod,
                          onPeriodChanged: (p) =>
                              setState(() => _selectedPeriod = p),
                        ),

                        28.height,

                        // ── Select other vitals ──────────────────────────────────────
                        const Text(
                          'Select other vitals',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),

                        16.height,

                        // ── Vitals grid ──────────────────────────────────────────────
                        _VitalsGrid(
                          vitals: _vitals,
                          selectedIndex: _selectedVital,
                          onSelected: (i) => setState(() => _selectedVital = i),
                        ),
                      ],
                    ),
                    const VitalHistoryTab(),
                    const CurrentMedsTab(),
                  ],
                ),
              ),
              30.height,
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Health Tabs ──────────────────────────────────────────────────────────────
class _HealthTabs extends StatelessWidget {
  final TabController controller;

  const _HealthTabs({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      labelColor: _green,
      unselectedLabelColor: Colors.grey.shade500,
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      unselectedLabelStyle:
          const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      indicatorColor: _green,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2.5,
      dividerColor: Colors.grey.shade200,
      tabs: const [
        Tab(text: 'Test Statistics'),
        Tab(text: 'Vital History'),
        Tab(text: 'Current Meds'),
      ],
    );
  }
}

// ─── Vital Chart Card ─────────────────────────────────────────────────────────
class _VitalChartCard extends StatelessWidget {
  final String selectedPeriod;
  final ValueChanged<String> onPeriodChanged;

  const _VitalChartCard({
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + period picker
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Vital Over Time',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              _PeriodPicker(
                selected: selectedPeriod,
                onChanged: onPeriodChanged,
              ),
            ],
          ),

          20.height,

          // Chart
          SizedBox(
            height: 160,
            child: _LineChart(),
          ),
        ],
      ),
    );
  }
}

// ─── Period Picker ────────────────────────────────────────────────────────────
class _PeriodPicker extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const _PeriodPicker({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged('Week'),
      child: Row(
        children: [
          Text(
            selected,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 2),
          const Icon(Icons.keyboard_arrow_down,
              size: 16, color: Colors.black54),
        ],
      ),
    );
  }
}

// ─── Line Chart ───────────────────────────────────────────────────────────────
class _LineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Y-axis labels
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: ['40', '20', '10', '0']
              .map((l) => Text(
                    l,
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
                  ))
              .toList(),
        ),

        12.width,

        // Chart area
        Expanded(
          child: CustomPaint(
            painter: _LineChartPainter(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // X-axis labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _days
                      .map((d) => Text(
                            d,
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey.shade400),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final chartHeight = size.height - 20; // leave room for x-axis labels
    const maxVal = 42.0;
    const minVal = 0.0;

    double xStep = size.width / (_days.length - 1);

    // ── Grid lines ──────────────────────────────────────────────────────
    final gridPaint = Paint()
      ..color = Colors.grey.shade100
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
      final y = chartHeight * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // ── Helper: data → canvas y ─────────────────────────────────────────
    double toY(double val) =>
        chartHeight - (val - minVal) / (maxVal - minVal) * chartHeight;

    // ── Draw smooth line ─────────────────────────────────────────────────
    void drawSmoothLine(List<double> data, Color color) {
      final paint = Paint()
        ..color = color
        ..strokeWidth = 2.2
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final path = Path();
      final points = List.generate(
        data.length,
        (i) => Offset(i * xStep, toY(data[i])),
      );

      path.moveTo(points[0].dx, points[0].dy);

      for (int i = 0; i < points.length - 1; i++) {
        final cp1 = Offset(
          (points[i].dx + points[i + 1].dx) / 2,
          points[i].dy,
        );
        final cp2 = Offset(
          (points[i].dx + points[i + 1].dx) / 2,
          points[i + 1].dy,
        );
        path.cubicTo(
          cp1.dx,
          cp1.dy,
          cp2.dx,
          cp2.dy,
          points[i + 1].dx,
          points[i + 1].dy,
        );
      }

      canvas.drawPath(path, paint);

      // Dot at each point
      final dotPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      for (final pt in points) {
        canvas.drawCircle(pt, 3, dotPaint);
      }
    }

    drawSmoothLine(_greenLine, _green);
    drawSmoothLine(_yellowLine, _yellow);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ─── Vitals Grid ──────────────────────────────────────────────────────────────
class _VitalsGrid extends StatelessWidget {
  final List<String> vitals;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _VitalsGrid({
    required this.vitals,
    required this.selectedIndex,
    required this.onSelected,
  });

  // Vitals that have a yellow/gold indicator in the design
  static const _yellowHighlighted = {'Blood Sugar'};

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vitals.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.6,
      ),
      itemBuilder: (context, i) {
        final isSelected = i == selectedIndex;
        final isYellow = _yellowHighlighted.contains(vitals[i]);

        Color bg = Colors.white;
        Color border = _borderColor;
        Color textColor = Colors.black54;

        if (isSelected) {
          bg = _lightGreen;
          border = _green;
          textColor = _green;
        } else if (isYellow) {
          bg = const Color(0xFFFFF8E1);
          border = _yellow;
          textColor = const Color(0xFF795548);
        }

        return GestureDetector(
          onTap: () => onSelected(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: border),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              vitals[i],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: textColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
