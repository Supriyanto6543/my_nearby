import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:my_restaurant/common/app_permission_enum.dart';
import 'package:my_restaurant/features/domain/entities/direction_entity.dart';
import 'package:my_restaurant/features/domain/usecase/get_direction.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(this.getDirection) : super(MapInitial());
  final GetDirection getDirection;

  fetchDirection(LatLng ori, LatLng dis) async {
    final result = await getDirection.execute(ori, dis);
    result.fold((l) {
      emit(MapError(AppPermissionEnum.notFound));
    }, (r) {
      emit(MapLoaded(r, AppPermissionEnum.approved));
    });
  }
}
