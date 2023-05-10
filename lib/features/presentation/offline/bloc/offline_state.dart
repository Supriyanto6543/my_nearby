part of 'offline_cubit.dart';

@immutable
abstract class OfflineState {}

class OfflineInitial extends OfflineState {}

class OfflineLoaded extends OfflineState {
  final List<ResultOfflineModel>? list;
  final AppPermissionEnum permissionEnum;

  OfflineLoaded(this.list, this.permissionEnum);
}

class OfflineError extends OfflineState {
  final AppPermissionEnum permissionEnum;

  OfflineError(this.permissionEnum);
}
