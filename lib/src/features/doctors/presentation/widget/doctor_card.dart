import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/constants/constants.dart';

import '../../../../constants/helper.dart';

class DoctorCard extends StatelessWidget {
  final String imageUrl;
  final String name;

  final String type;
  final String profession;
  final String hospital;
  final double rating;
  final int reviews;
  final bool isLiked;
  final bool isShowLove;
  final bool isShowImg;
  final bool isShowVerified;
  final VoidCallback onPress;

  const DoctorCard(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.type,
      required this.profession,
      required this.hospital,
      required this.rating,
      required this.reviews,
      required this.isLiked,
      required this.onPress,
      this.isShowImg = true,
      this.isShowVerified = false,
      this.isShowLove = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Card(
        color: const Color(0xffE9F8EA).withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Row(
            children: [
              if (isShowImg)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl.startsWith('http')
                        ? imageUrl
                        : imageUrl.contains('/UploadedFiles')
                            ? '${AppConstants.noSlashImageURL}$imageUrl'
                            : '${AppConstants.noSlashImageURL}/$imageUrl',
                    height: 100,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Handle name split and initials
                      final fullName = name;
                      final nameParts = fullName.trim().split(RegExp(r'\s+'));
                      String initials = '';
                      final nonTitleParts =
                          nameParts.where((p) => !p.endsWith('.')).toList();
                      if (nonTitleParts.isNotEmpty) {
                        initials += nonTitleParts.first[0];
                        if (nonTitleParts.length > 1) {
                          initials += nonTitleParts.last[0];
                        }
                      }

                      return Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                          color: getAvatarColor(fullName),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          initials.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xff3C3B3B),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            tiny5HorSpace(),
                            if (isShowVerified)
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xffD9FEAA),
                                    border: Border.all(
                                        color: ColorConstant.primaryColor)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.verified,
                                        color: ColorConstant.primaryColor,
                                      ),
                                      tiny5HorSpace(),
                                      Text('Verified')
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                        if (isShowLove)
                          Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.grey,
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      type,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff3C3B3B),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text(
                          profession,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text('|',
                            style: TextStyle(
                              fontSize: 12,
                              color: ColorConstant.primaryColor,
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(width: 5),
                        Text(
                          hospital,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                        const SizedBox(width: 5),
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: ColorConstant.secondryColor),
                        ),
                        Text(
                          ' ($reviews reviews)',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: ColorConstant.secondryColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Divider(
                        color: Color(0xffD9D9D9),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
