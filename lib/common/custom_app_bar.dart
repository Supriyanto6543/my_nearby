import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_restaurant/common/common_shared.dart';
import 'package:my_restaurant/common/hex_color.dart';
import 'package:my_restaurant/extension/sizebox_extension.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, this.search, this.edit, required this.title})
      : super(key: key);

  final VoidCallback? search;
  final VoidCallback? edit;
  final String title;

  @override
  Widget build(BuildContext context) {
    final position = CommonShared.getCurPos;
    return Container(
      color: getColorFromHex(bgColorBlack),
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      height: kToolbarHeight * 3,
      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.sp),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: search,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 4.sp),
                      margin:
                          EdgeInsets.only(right: 0.sp, left: 0.sp, top: 32.sp),
                      color: getColorFromHex(bgColorApp),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 30.sp,
                            ),
                            16.toSizedBox(w: 16),
                            Text(
                              title,
                              style: TextStyle(color: Colors.white70),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                8.toSizedBox(w: 8),
                Container(
                  margin: EdgeInsets.only(top: 32.sp),
                  child: GestureDetector(
                    onTap: edit,
                    child: Icon(
                      Icons.edit,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 6.sp),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white70,
                ),
                Expanded(
                  child: Text(
                    position != null ? position[2] : '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
