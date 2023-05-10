import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizeBoxExtension on int {
  toSizedBox({int h = 0, int w = 0}) => SizedBox(
        height: h.sp,
        width: w.sp,
      );
}
