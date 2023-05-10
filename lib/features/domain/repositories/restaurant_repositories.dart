import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_restaurant/common/failure.dart';
import 'package:my_restaurant/features/domain/entities/direction_entity.dart';
import 'package:my_restaurant/features/domain/entities/result_entity.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, List<ResultEntity>>> getHomePage(
      String lat, String long, String type);
  Future<Either<Failure, List<ResultEntity>>> getSearch(
      String search, String type);
  Future<Either<Failure, List<DirectionEntity>>> getDirection(
      LatLng ori, LatLng dis);
}
