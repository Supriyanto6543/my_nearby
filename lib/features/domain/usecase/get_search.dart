import 'package:dartz/dartz.dart';
import 'package:my_restaurant/common/failure.dart';
import 'package:my_restaurant/features/domain/entities/result_entity.dart';
import 'package:my_restaurant/features/domain/repositories/restaurant_repositories.dart';

class GetSearch {
  final RestaurantRepository restaurantRepository;

  GetSearch(this.restaurantRepository);

  Future<Either<Failure, List<ResultEntity>>> execute(
      String search, String type) {
    return restaurantRepository.getSearch(search, type);
  }
}
