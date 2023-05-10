part of 'account_place_cubit.dart';

@immutable
abstract class AccountPlaceState {}

class AccountPlaceInitial extends AccountPlaceState {}

class AccountPlaceLoaded extends AccountPlaceState {
  final List<LocalPlaceModel> list;
  final AppPermissionEnum permissionEnum;

  AccountPlaceLoaded(this.list, this.permissionEnum);
}

class AccountPlaceError extends AccountPlaceState {
  final AppPermissionEnum appPermissionEnum;

  AccountPlaceError(this.appPermissionEnum);
}
