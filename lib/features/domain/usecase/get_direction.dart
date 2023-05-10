import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_restaurant/common/failure.dart';
import 'package:my_restaurant/features/domain/entities/direction_entity.dart';
import 'package:my_restaurant/features/domain/repositories/restaurant_repositories.dart';

class GetDirection {
  final RestaurantRepository restaurantRepository;

  GetDirection(this.restaurantRepository);
  Future<Either<Failure, List<DirectionEntity>>> execute(
      LatLng ori, LatLng dis) {
    return restaurantRepository.getDirection(ori, dis);
  }
}
