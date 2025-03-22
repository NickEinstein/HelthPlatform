import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/constants/constants.dart';

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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageUrl,
                  width: 80,
                  height: 100,
                  fit: BoxFit.cover,
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
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xff3C3B3B),
                            fontWeight: FontWeight.w700,
                          ),
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
                              color: Colors.black,
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
