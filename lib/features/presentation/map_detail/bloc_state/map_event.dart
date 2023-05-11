part of 'map_bloc.dart';

@immutable
abstract class MapBlocEvent extends Equatable {
  const MapBlocEvent();
  @override
  List<Object> get props => [];
}

class MapEventList extends MapBlocEvent {
  final LatLng ori;
  final LatLng dis;
  MapEventList(this.ori, this.dis);
}
