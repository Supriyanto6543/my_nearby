import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_restaurant/common/hex_color.dart';
import 'package:my_restaurant/common/routes.dart';
import 'package:my_restaurant/extension/list_extension.dart';
import 'package:my_restaurant/extension/sizebox_extension.dart';
import 'package:my_restaurant/features/data/model/geometry_model.dart';
import 'package:my_restaurant/features/data/model/location_model.dart';
import 'package:my_restaurant/features/domain/entities/result_entity.dart';
import 'package:my_restaurant/features/presentation/offline/bloc/offline_cubit.dart';
import 'package:my_restaurant/injection.dart' as di;

import '../../../../common/custom_rating_bar.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.locator<OfflineCubit>()..fetchOfflineData(),
      child: BlocBuilder<OfflineCubit, OfflineState>(
        builder: (_, state) {
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: getColorFromHex(bgColorBlack),
                title: ListTile(
                  title: Text(
                    'Offline Data',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Terakhir diperbarui: ${state is OfflineLoaded ? state.list![0].dateUpdate!.split('.').first : ''}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              body: state is OfflineInitial
                  ? Center(
                      child: SizedBox(
                          height: 30.sp,
                          width: 30.sp,
                          child: CircularProgressIndicator()))
                  : state is OfflineLoaded
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              if (state.list != null)
                                10.toList(
                                    length: state.list!.length,
                                    builder: (_, index) {
                                      var model = state.list![index];
                                      var entity = ResultEntity(
                                          businessStatus: '',
                                          geometry: GeometryModel(
                                              location: LocationModel(
                                                  lat: double.parse(
                                                      model.geometryLat ??
                                                          '0.0'),
                                                  lng: double.parse(
                                                      model.geometryLang ??
                                                          '0.0'))),
                                          icon: model.icon ?? '',
                                          iconBackgroundColor: '',
                                          iconMaskBaseUri: '',
                                          name: model.name ?? '',
                                          placeId: '',
                                          rating: model.rating ?? 0.0,
                                          reference: model.reference ?? '',
                                          scope: '',
                                          types: [model.types ?? ''],
                                          userRatingsTotal:
                                              model.userRatingTotal ?? 0,
                                          vicinity: model.vicinity ?? '');
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, Routes.detailView,
                                              arguments: entity);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.sp,
                                              vertical: 8.sp),
                                          color: Colors.white70,
                                          child: Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: model.icon ?? '',
                                                width: 104.sp,
                                                height: 104.sp,
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child: SizedBox(
                                                      height: 34.sp,
                                                      width: 34.sp,
                                                      child:
                                                          CircularProgressIndicator()),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      model.name ?? '',
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Row(
                                                      children: [
                                                        CustomRatingBar(
                                                            starValue:
                                                                model.rating ??
                                                                    0.0),
                                                        10.toSizedBox(w: 10),
                                                        Text(
                                                            '(${model.userRatingTotal})')
                                                      ],
                                                    ),
                                                    Text(
                                                      model.vicinity ?? '',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                              else
                                Center(
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.sp),
                                    child: Text(
                                      'No data available yet',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18.sp),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        )
                      : Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: Text(
                              'Something went wrong, try again later',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.sp),
                            ),
                          ),
                        ));
        },
      ),
    );
  }
}
