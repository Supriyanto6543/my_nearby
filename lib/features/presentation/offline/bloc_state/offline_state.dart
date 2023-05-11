part of 'offline_bloc.dart';

@immutable
abstract class OfflineBlocState extends Equatable {
  const OfflineBlocState();
  @override
  List<Object> get props => [];
}

class OfflineBlocInitial extends OfflineBlocState {}

class OfflineBlocLoaded extends OfflineBlocState {
  final List<ResultOfflineModel>? list;
  final AppPermissionEnum permissionEnum;

  OfflineBlocLoaded(this.list, this.permissionEnum);
}

class OfflineBlocError extends OfflineBlocState {
  final AppPermissionEnum permissionEnum;

  OfflineBlocError(this.permissionEnum);
}
