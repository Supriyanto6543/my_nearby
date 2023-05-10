import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:my_restaurant/common/app_permission_enum.dart';
import 'package:my_restaurant/common/common_shared.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  checkingPermission() async {
    emit(SplashInitial());

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      emit(SplashError(AppPermissionEnum.offline, "You are offline"));
    } else {
      StreamSubscription<ServiceStatus>? subs;
      StreamSubscription<Position>? position;
      LocationPermission locationPermission;
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!isServiceEnabled) {
        final data = await Geolocator.requestPermission();
        if (data == LocationPermission.whileInUse ||
            data == LocationPermission.always) {
          Future.delayed(Duration(seconds: 2)).then((_) async {
            await Geolocator.openLocationSettings();
            subs = Geolocator.getServiceStatusStream().listen((event) => event);
            position = Geolocator.getPositionStream().listen((event) => event);
          });
        }
      } else {
        await Geolocator.requestPermission();
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        getAddress(position);
      }

      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.deniedForever) {
        emit(SplashError(AppPermissionEnum.denied,
            'Location permissions are permanently denied, cannot request a permissions'));
      }

      checkingCurrentPosition(subs, position);
    }
  }

  checkingCurrentPosition(StreamSubscription<ServiceStatus>? subs,
      StreamSubscription<Position>? position) {
    subs =
        Geolocator.getServiceStatusStream().listen((ServiceStatus event) async {
      if (event == ServiceStatus.enabled) {
        await Geolocator.requestPermission();
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        getAddress(position);
      }
    });
  }

  getAddress(Position pos) async {
    final latitude = pos.latitude;
    final longitude = pos.longitude;
    List<Placemark> place = await placemarkFromCoordinates(latitude, longitude);
    Placemark mark = place[0];
    String address =
        "${mark.country} ${mark.subAdministrativeArea} ${mark.administrativeArea} ${mark.subLocality} ${mark.postalCode}";
    CommonShared.currentPosition(
        latitude.toString(), longitude.toString(), address);
    emit(SplashLoaded(AppPermissionEnum.approved, "Get your location !!!",
        latitude, longitude, address));
  }
}
