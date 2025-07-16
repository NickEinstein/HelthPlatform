import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/app_pkg.dart';

import '../../../../constants/helper.dart';
import '../../../../utils/network_img_fallback.dart';

class SearchCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final VoidCallback onButtonPressed;

  const SearchCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onButtonPressed,
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
              child: Image.network(
                (widget.imageUrl).startsWith('http')
                    ? widget.imageUrl
                    : '${AppConstants.noSlashImageURL}${widget.imageUrl}',
                width: 60,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  final firstName = widget.title;
                  final initials = (firstName.isNotEmpty ? firstName[0] : '');

                  return Container(
                    width: 60,
                    height: 70,
                    decoration: BoxDecoration(
                      color: getAvatarColor(firstName),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            16, // Adjusted from 24 to better fit the avatar
                      ),
                    ),
                  );
                },
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
                      Icon(
                        Icons.circle,
                        color: ColorConstant.primaryColor,
                        size: 12,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: ColorConstant
                              .secondryColor, // Temporary fix if ColorConstant has issues
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
}
