import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_restaurant/common/hex_color.dart';
import 'package:my_restaurant/common/routes.dart';
import 'package:my_restaurant/extension/sizebox_extension.dart';
import 'package:my_restaurant/features/domain/entities/result_entity.dart';

import '../../../../common/custom_rating_bar.dart';
import '../../../../common/custom_snackbar.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.entity}) : super(key: key);

  final ResultEntity entity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: getColorFromHex(bgColorBlack),
        title: Text(
          'Detail',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: entity.icon,
            height: 200.sp,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                12.toSizedBox(h: 12),
                Text(
                  entity.name,
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                12.toSizedBox(h: 12),
                Wrap(
                  children: List.generate(
                      entity.types.length,
                      (index) => Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 4.sp, vertical: 2.sp),
                            padding: EdgeInsets.all(8.sp),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                border: Border.all(color: Colors.grey)),
                            child: Text(entity.types[index]),
                          )),
                ),
                10.toSizedBox(h: 10),
                Row(
                  children: [
                    CustomRatingBar(starValue: entity.rating ?? 0.0),
                    10.toSizedBox(w: 10),
                    Text('(${entity.userRatingsTotal})')
                  ],
                ),
                10.toSizedBox(h: 10),
                Text(
                  entity.vicinity,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Connectivity().checkConnectivity().then((value) {
                if (value == ConnectivityResult.none) {
                  CustomSnackBar.displaySnackBar(
                      context, SnackMode.error, "You are offline");
                } else {
                  Navigator.pushNamed(context, Routes.detailMap, arguments: {
                    'position': LatLng(entity.geometry.location.lat,
                        entity.geometry.location.lng),
                    'title': entity.name
                  });
                }
              });
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.sp),
              margin: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                  color: getColorFromHex(bgColorApp),
                  borderRadius: BorderRadius.circular(10.sp)),
              child: Text(
                'Open Detail',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp),
              ),
            ),
          )
        ],
      ),
    );
  }
}
