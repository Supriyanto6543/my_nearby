import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_restaurant/common/custom_app_bar.dart';
import 'package:my_restaurant/common/custom_rating_bar.dart';
import 'package:my_restaurant/common/routes.dart';
import 'package:my_restaurant/extension/list_extension.dart';
import 'package:my_restaurant/extension/sizebox_extension.dart';
import 'package:my_restaurant/features/presentation/home/bloc/home_cubit.dart';
import 'package:my_restaurant/features/presentation/navigation/pages/bottom_bar.dart';
import 'package:my_restaurant/injection.dart' as di;

import '../../../../common/common_shared.dart';
import '../../../../common/custom_offline.dart';
import '../../../../common/hex_color.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final position = CommonShared.getCurPos;
    String lat = position != null ? position[0] : '';
    String long = position != null ? position[1] : '';

    return BlocProvider(
      create: (context) =>
          di.locator<HomeCubit>()..fetchHomePage(lat, long, type: 'restaurant'),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return NestedScrollView(
              floatHeaderSlivers: false,
              headerSliverBuilder: (_, bool innerBox) {
                return [
                  SliverAppBar(
                    floating: true,
                    pinned: false,
                    snap: true,
                    expandedHeight: kToolbarHeight * 1.8,
                    automaticallyImplyLeading: false,
                    backgroundColor: getColorFromHex(bgColorBlack),
                    flexibleSpace: CustomAppBar(
                      title: 'Search restaurant here...',
                      search: () {
                        Navigator.pushNamed(context, Routes.search,
                            arguments: 'restaurant');
                      },
                      edit: () {
                        BottomBar.listen.value = 3;
                      },
                    ),
                  )
                ];
              },
              body: state is HomeInitial
                  ? Center(
                      child: SizedBox(
                          height: 30.sp,
                          width: 30.sp,
                          child: CircularProgressIndicator()))
                  : state is HomeLoaded
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              if (state.list != null)
                                10.toList(
                                    length: state.list!.length,
                                    builder: (_, index) {
                                      var model = state.list![index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, Routes.detailView,
                                              arguments: model);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.sp,
                                              vertical: 8.sp),
                                          color: Colors.white70,
                                          child: Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: model.icon,
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
                                                      model.name,
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
                                                            '(${model.userRatingsTotal})')
                                                      ],
                                                    ),
                                                    Text(
                                                      model.vicinity,
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
                      : state is HomeError
                          ? Center(
                              child: CustomOffline(
                                refresh: () {
                                  context.read<HomeCubit>().fetchHomePage(
                                      lat, long,
                                      type: 'restaurant');
                                },
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
