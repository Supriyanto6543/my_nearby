import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:my_restaurant/common/failure.dart';
import 'package:my_restaurant/features/data/datasource/remote_data.dart';
import 'package:my_restaurant/features/domain/entities/direction_entity.dart';
import 'package:my_restaurant/features/domain/entities/result_entity.dart';
import 'package:my_restaurant/features/domain/repositories/restaurant_repositories.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataImpl remoteDataImpl;

  RestaurantRepositoryImpl(this.remoteDataImpl);

  @override
  Future<Either<Failure, List<ResultEntity>>> getHomePage(
      String lat, String long, String type) async {
    // TODO: implement getHomePage
    try {
      final result = await remoteDataImpl.getHomePage(lat, long, type);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on SocketException catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ResultEntity>>> getSearch(
      String search, String type) async {
    // TODO: implement getSearch
    try {
      final result = await remoteDataImpl.getSearch(search, type);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on SocketException catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DirectionEntity>>> getDirection(
      LatLng ori, LatLng dis) async {
    // TODO: implement getDirection
    try {
      final result = await remoteDataImpl.getDirection(ori, dis);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on SocketException catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }
  }
}
