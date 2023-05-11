import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:my_restaurant/injection.dart' as di;

import '../../../../common/app_permission_enum.dart';
import '../../../domain/entities/direction_entity.dart';
import '../../../domain/usecase/get_direction.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapBlocEvent, MapBlocState> {
  MapBloc() : super(MapBlocInitial()) {
    final GetDirection getDirection = GetDirection(di.locator());
    on<MapEventList>((event, emit) async {
      // TODO: implement event handler
      final result = await getDirection.execute(event.ori, event.dis);
      result.fold((l) {
        emit(MapBlocError(AppPermissionEnum.notFound));
      }, (r) {
        emit(MapBlocLoaded(r, AppPermissionEnum.approved));
      });
    });
  }
}
