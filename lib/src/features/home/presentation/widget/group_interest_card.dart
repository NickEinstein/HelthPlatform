import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';

class GroupInterestCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final VoidCallback onViewProfile;
  final bool isFirst;
  final bool isLast;
  final bool isFriend;

  const GroupInterestCard({
    Key? key,
    this.isFriend = false,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.onViewProfile,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.only(
      topLeft: isFirst ? const Radius.circular(12) : Radius.zero,
      topRight: isFirst ? const Radius.circular(12) : Radius.zero,
      bottomLeft: isLast ? const Radius.circular(12) : Radius.zero,
      bottomRight: isLast ? const Radius.circular(12) : Radius.zero,
    );

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: const Color(0xffC2C2C2).withValues(alpha: 0.5)),
        borderRadius: borderRadius,
      ),
      color: isFriend ? const Color(0xFFEAFFEB) : const Color(0xFFF7F7F7),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      child: Padding( 
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Profile image
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image.network(
                  imageUrl,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/profimg.png',
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Name and Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff0D0D0D),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            // View Profile Button
            InkWell(
              onTap: onViewProfile,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorConstant.primaryColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Text(
                    isFriend ? 'View Profile' : 'View Group',
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
