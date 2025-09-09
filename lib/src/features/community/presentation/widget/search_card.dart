import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../../constants/helper.dart';

class SearchCard extends StatefulWidget {
  final String? imageUrl;
  final String? title;
  final String? subtitle;
  final VoidCallback onButtonPressed;

  const SearchCard({
    Key? key,
    this.imageUrl,
    this.title,
    this.subtitle,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  @override
  Widget build(BuildContext context) {
    final safeTitle = widget.title ?? '';
    final safeSubtitle = widget.subtitle ?? '';

    return InkWell(
      onTap: widget.onButtonPressed,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image or fallback initials
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                  ? Image.network(
                      widget.imageUrl!.startsWith('http')
                          ? widget.imageUrl!
                          : '${AppConstants.noSlashImageURL}${widget.imageUrl!}',
                      width: 60,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        final initials =
                            safeTitle.isNotEmpty ? safeTitle[0] : '?';
                        return _buildFallbackAvatar(initials, safeTitle);
                      },
                    )
                  : _buildFallbackAvatar(
                      safeTitle.isNotEmpty ? safeTitle[0] : '?',
                      safeTitle,
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
                    safeTitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff3C3B3B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        color: ColorConstant.primaryColor,
                        size: 12,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        safeSubtitle,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: ColorConstant.secondryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackAvatar(String initials, String seed) {
    return Container(
      width: 60,
      height: 70,
      decoration: BoxDecoration(
        color: getAvatarColor(seed),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
