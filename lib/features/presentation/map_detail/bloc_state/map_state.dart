part of 'map_bloc.dart';

@immutable
abstract class MapBlocState {}

class MapBlocInitial extends MapBlocState {}

class MapBlocLoaded extends MapBlocState {
  final AppPermissionEnum appPermissionEnum;
  final List<DirectionEntity> direction;

  MapBlocLoaded(this.direction, this.appPermissionEnum);
}

class MapBlocError extends MapBlocState {
  final AppPermissionEnum appPermissionEnum;
  MapBlocError(this.appPermissionEnum);
}
