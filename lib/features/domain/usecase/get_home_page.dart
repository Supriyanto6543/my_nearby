import 'package:dartz/dartz.dart';
import 'package:my_restaurant/common/failure.dart';
import 'package:my_restaurant/features/domain/entities/result_entity.dart';
import 'package:my_restaurant/features/domain/repositories/restaurant_repositories.dart';

class GetHomePage {
  final RestaurantRepository restaurantRepository;

  GetHomePage(this.restaurantRepository);
  Future<Either<Failure, List<ResultEntity>>> execute(
      String lat, String long, String type) {
    return restaurantRepository.getHomePage(lat, long, type);
  }
}
