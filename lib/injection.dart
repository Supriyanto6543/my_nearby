import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_restaurant/common/db_helper.dart';
import 'package:my_restaurant/features/data/datasource/remote_data.dart';
import 'package:my_restaurant/features/data/repositories/restaurant_repository_impl.dart';
import 'package:my_restaurant/features/domain/repositories/restaurant_repositories.dart';
import 'package:my_restaurant/features/domain/usecase/get_direction.dart';
import 'package:my_restaurant/features/domain/usecase/get_home_page.dart';
import 'package:my_restaurant/features/domain/usecase/get_search.dart';
import 'package:my_restaurant/features/presentation/account/bloc/account_place_cubit.dart';
import 'package:my_restaurant/features/presentation/home/bloc/home_cubit.dart';
import 'package:my_restaurant/features/presentation/map_detail/bloc/map_cubit.dart';
import 'package:my_restaurant/features/presentation/offline/bloc/offline_cubit.dart';
import 'package:my_restaurant/features/presentation/search/bloc/search_cubit.dart';

final locator = GetIt.instance;
void init() {
  //bloc state
  locator.registerFactory(() => HomeCubit(locator()));
  locator.registerFactory(() => SearchCubit(locator()));
  locator.registerFactory(() => MapCubit(locator()));
  locator.registerFactory(() => AccountPlaceCubit(locator()));
  locator.registerFactory(() => OfflineCubit(locator()));

  //dio
  locator.registerFactory(() => Dio());

  //use case
  locator.registerFactory(() => GetHomePage(locator()));
  locator.registerFactory(() => GetSearch(locator()));
  locator.registerFactory(() => GetDirection(locator()));

  //data source
  locator.registerFactory(() => RestaurantRemoteDataImpl(locator(), locator()));

  //db helper
  locator.registerFactory(() => DbHelper());

  //repository
  locator.registerFactory<RestaurantRepository>(
      () => RestaurantRepositoryImpl(locator()));
}
