part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ResultEntity>? list;
  final String message;
  final AppPermissionEnum permissionEnum;

  HomeLoaded(this.list, this.message, this.permissionEnum);
}

class HomeError extends HomeState {
  final String message;
  final AppPermissionEnum permissionEnum;

  HomeError(this.message, this.permissionEnum);
}
