import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

class GroupCard extends ConsumerStatefulWidget {
  // ✅ Convert to ConsumerStatefulWidget
  final String imageUrl;
  final String title;
  final String subtitle;
  final String buttonText;
  final bool isLoading;
  final bool isMember;
  final VoidCallback onButtonPressed;
  final VoidCallback onPressed;

  const GroupCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.isMember,
    required this.isLoading,
    required this.onPressed,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends ConsumerState<GroupCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: (widget.imageUrl.isNotEmpty &&
                      Uri.tryParse(widget.imageUrl)?.hasAbsolutePath == true)
                  ? Image.network(
                      widget.imageUrl,
                      width: 80,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/images/fitness1.png',
                          width: 80,
                          height: 100,
                          fit: BoxFit.cover),
                    )
                  : Image.asset(
                      widget.imageUrl,
                      width: 80,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
            ),

            const SizedBox(width: 12),

            // Title and Subtitle with Button
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff3C3B3B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: ColorConstant.secondryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (!widget.isMember)
                    widget.isLoading
                        ? const CircularProgressIndicator() // ✅ Show loading
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.primaryColor,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              // ✅ Handle loading inside button
                              widget.onButtonPressed();
                            },
                            child: Text(
                              widget.buttonText,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
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
