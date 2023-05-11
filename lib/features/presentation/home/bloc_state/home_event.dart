part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class HomeEventList extends HomeEvent {
  final String lat;
  final String long;
  final String type;

  HomeEventList(this.lat, this.long, this.type);
}
