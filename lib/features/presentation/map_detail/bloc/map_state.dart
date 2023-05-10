part of 'map_cubit.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {}

class MapLoaded extends MapState {
  final AppPermissionEnum appPermissionEnum;
  final List<DirectionEntity> direction;

  MapLoaded(this.direction, this.appPermissionEnum);
}

class MapError extends MapState {
  final AppPermissionEnum appPermissionEnum;
  MapError(this.appPermissionEnum);
}
