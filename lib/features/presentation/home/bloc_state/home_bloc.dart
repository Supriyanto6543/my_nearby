import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_restaurant/injection.dart' as di;

import '../../../../common/app_permission_enum.dart';
import '../../../domain/entities/result_entity.dart';
import '../../../domain/usecase/get_home_page.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeBlocState> {
  HomeBloc() : super(HomeBlocInitial()) {
    final GetHomePage getHomePage = GetHomePage(di.locator());

    on<HomeEventList>((event, emit) async {
      emit(HomeBlocInitial());

      final connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.none) {
        emit(HomeBlocError("You are offline", AppPermissionEnum.offline));
      } else {
        final result =
            await getHomePage.execute(event.lat, event.long, event.type);
        result.fold((l) {
          emit(HomeBlocError(l.toString(), AppPermissionEnum.error));
        }, (r) {
          emit(HomeBlocLoaded(
              r, 'success load home page', AppPermissionEnum.approved));
        });
      }
    });
  }
}
