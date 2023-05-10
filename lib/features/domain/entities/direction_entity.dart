import 'package:equatable/equatable.dart';

import '../../data/model/direction_model.dart';

class DirectionEntity extends Equatable {
  DirectionEntity({
    required this.bounds,
    required this.copyrights,
    required this.legs,
    required this.overviewPolyline,
  });
  late final Bounds bounds;
  late final String copyrights;
  late final List<Legs> legs;
  late final OverviewPolyline overviewPolyline;

  DirectionEntity.fromJson(Map<String, dynamic> json) {
    bounds = Bounds.fromJson(json['bounds']);
    copyrights = json['copyrights'];
    legs = List.from(json['legs']).map((e) => Legs.fromJson(e)).toList();
    overviewPolyline = OverviewPolyline.fromJson(json['overview_polyline']);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [bounds, copyrights, legs, overviewPolyline];
}
