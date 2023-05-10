import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_restaurant/common/app_permission_enum.dart';
import 'package:my_restaurant/extension/list_extension.dart';
import 'package:my_restaurant/extension/sizebox_extension.dart';

import '../../../../common/custom_offline.dart';
import '../../../../common/custom_rating_bar.dart';
import '../../../../common/hex_color.dart';
import '../../../../common/routes.dart';
import '../bloc/search_cubit.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: SearchCubit.scaffold,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: getColorFromHex(bgColorApp),
        elevation: 0,
        title: Container(
          width: double.infinity,
          height: 40,
          color: Colors.white,
          child: Center(
            child: TextField(
              autofocus: true,
              controller: SearchCubit.inputSearch,
              onChanged: (value) {
                context.read<SearchCubit>().searchNearby(value, type);
              },
              onSubmitted: (_) {
                context.read<SearchCubit>().searchNearby(_, type);
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search...',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.sp)),
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
        if (state is SearchLoaded) {
          if (state.enumStatus == AppPermissionEnum.nothing) {
            return Center(
              child: Text(
                'Search your favorite novel',
                style: TextStyle(color: Colors.black),
              ),
            );
          } else if (state.enumStatus == AppPermissionEnum.searched) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  if (state.list != null)
                    10.toList(
                        length: state.list!.length,
                        builder: (_, index) {
                          var model = state.list![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.detailView,
                                  arguments: model);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.sp, vertical: 8.sp),
                              color: Colors.white70,
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: model.icon,
                                    width: 104.sp,
                                    height: 104.sp,
                                    placeholder: (context, url) => Center(
                                      child: SizedBox(
                                          height: 34.sp,
                                          width: 34.sp,
                                          child: CircularProgressIndicator()),
                                    ),
                                    errorWidget: (context, url, error) =>
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
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Row(
                                          children: [
                                            CustomRatingBar(
                                                starValue: model.rating ?? 0.0),
                                            10.toSizedBox(w: 10),
                                            Text('(${model.userRatingsTotal})')
                                          ],
                                        ),
                                        Text(
                                          model.vicinity,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400),
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
                        margin: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Text(
                          'No data available yet',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp),
                        ),
                      ),
                    )
                ],
              ),
            );
          } else if (state.enumStatus == AppPermissionEnum.search) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          } else if (state.enumStatus == AppPermissionEnum.notFound) {
            return Container(
              margin: EdgeInsets.all(15),
              child: Center(
                child: Text(
                  '${SearchCubit.inputSearch.text} not found in Database',
                  style: TextStyle(color: Colors.black, fontSize: 18.sp),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        } else if (state is SearchError) {
          return Center(
            child: CustomOffline(
              refresh: () {
                context.read<SearchCubit>().searchNearby("", type);
              },
            ),
          );
        }
        return SizedBox.shrink();
      }),
    );
  }
}
