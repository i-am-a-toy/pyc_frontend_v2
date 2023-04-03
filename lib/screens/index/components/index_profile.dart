import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/screens/components/labe/default_rounded_label.dart';
import 'package:shimmer/shimmer.dart';

class IndexProfile extends StatelessWidget {
  final String image;
  final String role;
  final String name;

  const IndexProfile({
    Key? key,
    required this.image,
    required this.role,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      width: double.infinity,
      child: Column(
        children: [
          kHeightSizeBox,
          SizedBox(
            width: double.infinity,
            height: 120.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    DefaultRoundedLabel(label: role),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        kHalfHeightSizeBox,
                        const Text(
                          '안녕하세요!',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 30.0,
                          ),
                        ),
                        Text(
                          '$name님',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: kSecondaryColor,
                  backgroundImage: NetworkImage(image),
                  maxRadius: 60.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ShimmerIndexUserProfile extends StatelessWidget {
  const ShimmerIndexUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade100,
        highlightColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey,
              ),
            ),
            const CircleAvatar(maxRadius: 60.0)
          ],
        ),
      ),
    );
  }
}
