import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ListExtension on int {
  toList(
          {int length = 1,
          NullableIndexedWidgetBuilder? builder,
          bool isVertical = true}) =>
      ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount: length,
        itemBuilder: builder!,
        separatorBuilder: (_, int index) {
          return Divider(
            color: Colors.black.withOpacity(0.2),
            thickness: 1.2.sp,
            height: 1.2.sp,
          );
        },
      );

  toGrid({List<Widget>? children}) => GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(4.0),
        childAspectRatio: 8.0 / 9.0,
        children: children!,
      );
}
