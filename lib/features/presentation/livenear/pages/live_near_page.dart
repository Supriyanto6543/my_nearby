import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_restaurant/common/custom_rating_bar.dart';
import 'package:my_restaurant/common/hex_color.dart';
import 'package:my_restaurant/extension/sizebox_extension.dart';
import 'package:my_restaurant/features/presentation/home/bloc/home_cubit.dart';
import 'package:my_restaurant/features/presentation/map_detail/bloc/map_cubit.dart';
import 'package:my_restaurant/injection.dart' as di;

import '../../../../common/common_shared.dart';

class LiveNearPage extends StatefulWidget {
  const LiveNearPage({Key? key}) : super(key: key);

  @override
  State<LiveNearPage> createState() => _MapDetailPageState();
}

class _MapDetailPageState extends State<LiveNearPage> {
  GoogleMapController? _controller;
  CameraPosition? cameraPosition;
  Set<Marker> marker = {};
  String? updateLat;
  String? updateLong;

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final position = CommonShared.getCurPos;
    String lat = position != null ? position[0] : '';
    String long = position != null ? position[1] : '';
    final cameraPos = CameraPosition(
        target: LatLng(double.tryParse(lat)!, double.tryParse(long)!),
        zoom: 13.5);

    return BlocProvider(
      create: (_) => di.locator<MapCubit>()
        ..fetchDirection(LatLng(double.tryParse(lat)!, double.tryParse(long)!),
            LatLng(0, 0)),
      child: BlocBuilder<MapCubit, MapState>(builder: (_, state) {
        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                zoomGesturesEnabled: true,
                initialCameraPosition: CameraPosition(
                    target: LatLng(double.parse(lat), double.parse(long)),
                    zoom: 12),
                mapType: MapType.hybrid,
                onCameraMove: (position) {
                  cameraPosition = position;
                },
                onCameraIdle: () async {
                  setState(() {
                    updateLat = cameraPosition!.target.latitude.toString();
                    updateLong = cameraPosition!.target.longitude.toString();
                  });
                },
                onMapCreated: (controller) => _controller = controller,
              ),
              Center(
                child: Icon(
                  Icons.emoji_people,
                  size: 40.sp,
                  color: Colors.orange,
                ),
              ),
              BlocConsumer(
                  listener: (context, state) {},
                  listenWhen: (context, state) {
                    return state is HomeLoaded ? true : false;
                  },
                  bloc: di.locator<HomeCubit>()
                    ..fetchHomePage(updateLat ?? lat, updateLong ?? long),
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      return Positioned(
                        bottom: 10,
                        right: 0,
                        left: 0,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            height: 180.sp,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.list!.length,
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (_, int index) {
                                var model = state.list![index];
                                return SingleChildScrollView(
                                  child: Container(
                                    height: 160.sp,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.sp)),
                                    padding: EdgeInsets.all(10.sp),
                                    margin: EdgeInsets.all(10.sp),
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: model.icon,
                                          fit: BoxFit.cover,
                                        ),
                                        Text(
                                          model.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            CustomRatingBar(
                                                starValue: model.rating ?? 0.0),
                                            10.toSizedBox(w: 10),
                                            Text(
                                                '(${model.userRatingsTotal ?? 0})')
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    } else if (state is HomeInitial) {
                      return Positioned(
                          bottom: 80,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Card(
                              child: Center(
                                child: SizedBox(
                                  height: 34.sp,
                                  width: 34.sp,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.orange,
                                  ),
                                ),
                              ),
                            ),
                          ));
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: getColorFromHex(bgColorApp),
            foregroundColor: Colors.white,
            onPressed: () => _controller!
                .animateCamera(CameraUpdate.newCameraPosition(cameraPos)),
            child: Icon(Icons.center_focus_strong),
          ),
        );
      }),
    );
  }
}
