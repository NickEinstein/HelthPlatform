import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/utils/custom_header.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

// ─── Constants ───────────────────────────────────────────────────────────────
const _green = Color(0xFF4CAF50);
const _lightGreen = Color(0xFFE8F5E9);
const _borderGreen = Color(0xFFA5D6A7);

// ─── Page ────────────────────────────────────────────────────────────────────
class LabPrescriptionLogPage extends StatelessWidget {
  const LabPrescriptionLogPage({super.key});

  /// Replace these with real image URLs / asset paths as needed
  static const _scanImages = [
    'assets/images/xray1.png',
    'assets/images/xray2.png',
   ];

  static const _reportText =
      'It is a long established fact that a reader will be distracted by the '
      'readable content of a page when looking at its layout. The point of '
      'using Lorem Ipsum is that it has a more-or-less normal distribution of '
      'letters, as opposed to using "Content here, content here", making it '
      'look like readable English.\n\n'
      'Many desktop publishing packages and web page editors now use Lorem '
      'Ipsum as their default model text, and a search for "lorem ipsum" will '
      'uncover many web sites still in their infancy. Various versions have '
      'evolved over the years, sometimes by accident, sometimes on purpose '
      '(injected humour and the like).';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,

              // ── Header ──────────────────────────────────────────────────
              CustomHeader(
                title: 'Prescription Log',
                onPressed: () => Navigator.pop(context),
              ),

              20.height,

              // ── Lab Work Report Card ─────────────────────────────────────
              _LabReportCard(reportText: _reportText),

              20.height,

              // ── Scan Images ──────────────────────────────────────────────
              ..._scanImages.map((url) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _ScanImageCard(imageUrl: url),
                  )),

              20.height,
            ],
          ),
        ),
      ),
    );
  }
}

class _LabReportCard extends StatelessWidget {
  final String reportText;

  const _LabReportCard({required this.reportText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Card title bar ──────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: const Text(
              'Lab Work Report',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),

          // ── Report body text ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              reportText,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
                height: 1.6,
              ),
            ),
          ),

          // ── Cost banner ─────────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: const BoxDecoration(
              color: _lightGreen,
              border: Border(
                top: BorderSide(color: _borderGreen),
                bottom: BorderSide(color: _borderGreen),
              ),
            ),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 4,
              children: [
                const Text(
                  'Med. Cost: ',
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
                Text(
                  '  |  ',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                ),
                const Text(
                  'HMO Cover: ',
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

          // ── Contribution ────────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
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

// ─── Scan Image Card ──────────────────────────────────────────────────────────
class _ScanImageCard extends StatelessWidget {
  final String imageUrl;

  const _ScanImageCard({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imageUrl,
        width: double.infinity,
        height: 300,
        fit: BoxFit.cover,
        // loadingBuilder: (context, child, loadingProgress) {
        //   if (loadingProgress == null) return child;
        //   return Container(
        //     width: double.infinity,
        //     height: 200,
        //     decoration: BoxDecoration(
        //       color: Colors.grey.shade200,
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //     child: Center(
        //       child: CircularProgressIndicator(
        //         value: loadingProgress.expectedTotalBytes != null
        //             ? loadingProgress.cumulativeBytesLoaded /
        //                 loadingProgress.expectedTotalBytes!
        //             : null,
        //         color: _green,
        //       ),
        //     ),
        //   );
        // },
        errorBuilder: (context, error, stackTrace) => _PlaceholderScan(),
      ),
    );
  }
}

// ─── Placeholder for offline/error state ─────────────────────────────────────
class _PlaceholderScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF1A237E).withOpacity(0.85),
        borderRadius: BorderRadius.circular(12),
      ),
      child: CustomPaint(
        painter: _XRayPainter(),
      ),
    );
  }
}

// ─── Simple X-ray placeholder painter ────────────────────────────────────────
class _XRayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Dark background
    paint.color = const Color(0xFF0D1B4B);
    canvas.drawRect(Offset.zero & size, paint);

    // Rib cage silhouette (simplified)
    paint.color = Colors.white.withOpacity(0.12);
    for (int i = 0; i < 6; i++) {
      final y = size.height * 0.2 + i * size.height * 0.1;
      final path = Path()
        ..moveTo(size.width * 0.25, y)
        ..quadraticBezierTo(size.width * 0.5, y - 14, size.width * 0.75, y)
        ..quadraticBezierTo(size.width * 0.5, y + 4, size.width * 0.25, y);
      canvas.drawPath(path, paint);
    }

    // Spine
    paint.color = Colors.white.withOpacity(0.18);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.47, size.height * 0.1, size.width * 0.06,
            size.height * 0.8),
        const Radius.circular(4),
      ),
      paint,
    );

    // Heat spot (like CT heatmap)
    final shader = RadialGradient(
      colors: [
        Colors.red.withOpacity(0.75),
        Colors.orange.withOpacity(0.45),
        Colors.yellow.withOpacity(0.2),
        Colors.transparent,
      ],
      stops: const [0.0, 0.35, 0.65, 1.0],
    ).createShader(Rect.fromCircle(
      center: Offset(size.width * 0.52, size.height * 0.62),
      radius: size.width * 0.28,
    ));
    paint.shader = shader;
    canvas.drawCircle(
      Offset(size.width * 0.52, size.height * 0.62),
      size.width * 0.28,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
