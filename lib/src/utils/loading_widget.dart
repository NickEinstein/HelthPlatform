import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';
import 'package:gap/gap.dart';

class ListLoader extends StatelessWidget {
  final int itemCount;
  final double height;
  final double width;

  const ListLoader({
    super.key,
    this.itemCount = 5,
    this.height = 60,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (context, index) => const Gap(10),
      itemBuilder: (context, index) {
        return Container(
          height: height.h,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ).shimmer();
      },
    );
  }
}

class TileLoader extends StatelessWidget {
  final int itemCount;

  const TileLoader({
    super.key,
    this.itemCount = 6,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ).shimmer();
      },
    );
  }
}

class HorizontalListTileLoader extends StatelessWidget {
  final int itemCount;
  final double height;
  final double width;

  const HorizontalListTileLoader({
    super.key,
    this.itemCount = 5,
    this.height = 120,
    this.width = 100,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (context, index) => const Gap(10),
        itemBuilder: (context, index) {
          return Container(
            width: width.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ).shimmer();
        },
      ),
    );
  }
}
