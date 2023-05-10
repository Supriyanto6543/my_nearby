import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOffline extends StatelessWidget {
  const CustomOffline({Key? key, this.refresh}) : super(key: key);

  final VoidCallback? refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.sp),
      child: ListTile(
        title: Text(
          'You are offline',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 20.sp),
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 20.sp),
          child: InkWell(
            onTap: refresh,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4.sp)),
              padding: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 10.sp),
              child: Text(
                'Refresh',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
