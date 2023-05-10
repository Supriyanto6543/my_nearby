import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_restaurant/common/hex_color.dart';
import 'package:my_restaurant/extension/sizebox_extension.dart';
import 'package:my_restaurant/features/presentation/map_detail/bloc/map_cubit.dart';
import 'package:my_restaurant/injection.dart' as di;

import '../../../../common/common_shared.dart';

class MapDetailPage extends StatefulWidget {
  const MapDetailPage({Key? key, required this.dis, required this.name})
      : super(key: key);

  final LatLng dis;
  final String name;

  @override
  State<MapDetailPage> createState() => _MapDetailPageState();
}

class _MapDetailPageState extends State<MapDetailPage> {
  GoogleMapController? _controller;
  Set<Marker> marker = {};

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
            LatLng(widget.dis.latitude, widget.dis.longitude)),
      child: BlocBuilder<MapCubit, MapState>(builder: (_, state) {
        if (state is MapLoaded) {
          PolylinePoints()
              .decodePolyline(state.direction[0].overviewPolyline.points)
              .map((e) {
            marker.add(Marker(
                markerId: MarkerId('my_marker'),
                infoWindow: InfoWindow(title: widget.name),
                icon: BitmapDescriptor.defaultMarker,
                position: LatLng(e.latitude, e.longitude)));
          }).toList();
        }
        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: cameraPos,
                markers: marker,
                polylines: {
                  if (state is MapLoaded)
                    Polyline(
                        polylineId: const PolylineId('overview_polyline'),
                        color: Colors.red,
                        width: 5,
                        points: PolylinePoints()
                            .decodePolyline(
                                state.direction[0].overviewPolyline.points)
                            .map((e) {
                          return LatLng(e.latitude, e.longitude);
                        }).toList()),
                },
                onMapCreated: (controller) => _controller = controller,
              ),
              if (state is MapLoaded)
                if (state.direction.isNotEmpty)
                  Positioned(
                    top: kToolbarHeight,
                    right: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF1976D2),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${state.direction[0].legs[0].distance.text}, ${state.direction[0].legs[0].duration.text}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          10.toSizedBox(h: 10),
                          Text(
                            'Berangkat: ${state.direction[0].legs[0].startAddress}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          6.toSizedBox(h: 6),
                          Text(
                            'Tujuan: ${state.direction[0].legs[0].endAddress}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
