import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:my_restaurant/features/domain/usecase/get_home_page.dart';

import '../../../../common/app_permission_enum.dart';
import '../../../domain/entities/result_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.getHomePage) : super(HomeInitial());

  final GetHomePage getHomePage;

  fetchHomePage(String lat, String long, {String type = 'hospital'}) async {
    emit(HomeInitial());
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      emit(HomeError("You are offline", AppPermissionEnum.offline));
    } else {
      final result = await getHomePage.execute(lat, long, type);
      result.fold((l) {
        emit(HomeError(l.toString(), AppPermissionEnum.error));
      }, (r) {
        emit(HomeLoaded(
            r, 'success load home page', AppPermissionEnum.approved));
      });
    }
  }
}
