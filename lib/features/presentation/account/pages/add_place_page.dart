import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_restaurant/features/data/model/local_place_model.dart';
import 'package:my_restaurant/features/presentation/account/bloc/account_place_cubit.dart';

class AddPlacePage extends StatefulWidget {
  const AddPlacePage({Key? key, required this.position}) : super(key: key);

  final LatLng position;

  @override
  State<AddPlacePage> createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage> {
  GoogleMapController? _controller;
  CameraPosition? cameraPosition;
  String? location;
  String? lat;
  String? long;

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          GoogleMap(
            zoomGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
                target:
                    LatLng(widget.position.latitude, widget.position.longitude),
                zoom: 12),
            mapType: MapType.hybrid,
            onCameraMove: (position) {
              cameraPosition = position;
            },
            onCameraIdle: () async {
              List<Placemark> place = await placemarkFromCoordinates(
                  cameraPosition!.target.latitude,
                  cameraPosition!.target.longitude);
              Placemark mark = place[0];
              String address =
                  "${mark.country} ${mark.subAdministrativeArea} ${mark.administrativeArea} ${mark.subLocality} ${mark.postalCode}";
              setState(() {
                lat = cameraPosition!.target.latitude.toString();
                long = cameraPosition!.target.longitude.toString();
                location = address;
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
          Positioned(
              bottom: 80,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Card(
                  child: Container(
                      padding: EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width - 40,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.location_on,
                              size: 40.sp,
                              color: Colors.orange,
                            ),
                            title: Text(
                              location ?? 'Geser dan tambahkan alamat',
                              style: TextStyle(
                                  fontSize: 18.sp, color: Colors.black),
                            ),
                            dense: true,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (location != null) {
                                var local = LocalPlaceModel(
                                    address: location ?? '',
                                    lat: lat ?? '',
                                    long: long ?? '');
                                context
                                    .read<AccountPlaceCubit>()
                                    .addLocalPlace(local)
                                    .then((value) {
                                  if (value == 200) {
                                    Navigator.pop(context, true);
                                  }
                                });
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.sp),
                              margin: EdgeInsets.all(10.sp),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  color: Colors.blueAccent),
                              child: Text(
                                'Add this Place',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ))
        ],
      ),
    );
  }
}
