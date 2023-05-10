import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_restaurant/features/data/model/direction_model.dart';
import 'package:my_restaurant/features/data/model/result_model.dart';
import 'package:my_restaurant/utils/constant.dart';

import '../../../common/common_shared.dart';
import '../../../common/db_helper.dart';

abstract class RestaurantRemoteData {
  Future<List<ResultModel>> getHomePage(String lat, String long, String type);
  Future<List<ResultModel>> getSearch(String search, String type);
  Future<List<DirectionModel>> getDirection(LatLng ori, LatLng dis);
  String get baseUrl;
}

class RestaurantRemoteDataImpl implements RestaurantRemoteData {
  late final Dio dio;
  final DbHelper dbHelper;

  RestaurantRemoteDataImpl(this.dio, this.dbHelper);

  @override
  Future<List<ResultModel>> getHomePage(
      String lat, String long, String type) async {
    // TODO: implement getHomePage
    final request = await dio.get(
        '${"$baseUrl${Constant.nearby}?${Constant.location}$lat"},$long${Constant.radius}$type${Constant.apiKey}');
    List result = request.data['results'];
    if (request.statusCode == 200) {
      List<ResultModel> toOffline =
          result.map((e) => ResultModel.fromJson(e)).toList();
      dbHelper.deleteAllSaveMode();
      for (var data in toOffline) {
        dbHelper.insertSaveMode(data);
      }
      return result.map((e) => ResultModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  // TODO: implement baseUrl
  String get baseUrl => Constant.baseUrl;

  @override
  Future<List<ResultModel>> getSearch(String search, String type) async {
    final position = CommonShared.getCurPos;
    String lat = position != null ? position[0] : '';
    String long = position != null ? position[1] : '';

    final request = await dio.get(
        '${"$baseUrl${Constant.nearby}?${Constant.keyword}$search&${Constant.location}$lat"},$long${Constant.radius}$type${Constant.apiKey}');
    List result = request.data['results'];
    if (request.statusCode == 200) {
      return result.map((e) => ResultModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<List<DirectionModel>> getDirection(LatLng ori, LatLng dis) async {
    // TODO: implement getDirection
    log("get url: ${"$baseUrl${Constant.destination}${dis.latitude},${dis.longitude}${Constant.origin}${ori.latitude}"},${ori.longitude}${Constant.apiKey}");
    final request = await dio.get(
        '${"$baseUrl${Constant.destination}${dis.latitude},${dis.longitude}${Constant.origin}${ori.latitude}"},${ori.longitude}${Constant.apiKey}');
    List result = request.data['routes'];
    if (request.statusCode == 200) {
      return result.map((e) => DirectionModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
