part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoaded extends SplashState {
  final AppPermissionEnum appPermissionEnum;
  final String message;
  final double lat;
  final double lang;
  final String address;

  SplashLoaded(
      this.appPermissionEnum, this.message, this.lat, this.lang, this.address);
}

class SplashError extends SplashState {
  final AppPermissionEnum appPermissionEnum;
  final String message;

  SplashError(this.appPermissionEnum, this.message);
}
