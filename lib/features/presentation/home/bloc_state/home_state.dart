part of 'home_bloc.dart';

@immutable
abstract class HomeBlocState extends Equatable {
  HomeBlocState();

  @override
  List<Object> get props => [];
}

class HomeBlocInitial extends HomeBlocState {}

class HomeBlocLoaded extends HomeBlocState {
  final List<ResultEntity>? list;
  final String message;
  final AppPermissionEnum permissionEnum;

  HomeBlocLoaded(this.list, this.message, this.permissionEnum);
}

class HomeBlocError extends HomeBlocState {
  final String message;
  final AppPermissionEnum permissionEnum;

  HomeBlocError(this.message, this.permissionEnum);
}
