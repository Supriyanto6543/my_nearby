import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRatingBar extends StatelessWidget {
  const CustomRatingBar({Key? key, required this.starValue}) : super(key: key);

  final double starValue;

  @override
  Widget build(BuildContext context) {
    Color color = starValue < 2 ? Colors.red : Color(0xFFF9A825);
    var starIconsMap = [1, 2, 3, 4, 5].map((e) {
      if (starValue >= e) {
        return Icon(
          Icons.star_rate,
          color: color,
          size: 16.sp,
        );
      } else if (starValue < e && starValue > e - 1) {
        return Icon(
          Icons.star_half,
          color: color,
          size: 16.sp,
        );
      } else {
        return Icon(
          Icons.star_border,
          color: color,
          size: 16.sp,
        );
      }
    }).toList();

    return Row(children: starIconsMap);
  }
}
