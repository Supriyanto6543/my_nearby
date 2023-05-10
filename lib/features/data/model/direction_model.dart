import 'package:equatable/equatable.dart';
import 'package:my_restaurant/features/domain/entities/direction_entity.dart';

class DirectionModel extends Equatable {
  DirectionModel({
    required this.bounds,
    required this.copyrights,
    required this.legs,
    required this.overviewPolyline,
  });
  late final Bounds bounds;
  late final String copyrights;
  late final List<Legs> legs;
  late final OverviewPolyline overviewPolyline;

  DirectionModel.fromJson(Map<String, dynamic> json) {
    bounds = Bounds.fromJson(json['bounds']);
    copyrights = json['copyrights'];
    legs = List.from(json['legs']).map((e) => Legs.fromJson(e)).toList();
    overviewPolyline = OverviewPolyline.fromJson(json['overview_polyline']);
  }

  DirectionEntity toEntity() => DirectionEntity(
      bounds: bounds,
      copyrights: copyrights,
      legs: legs,
      overviewPolyline: overviewPolyline);

  @override
  // TODO: implement props
  List<Object?> get props => [bounds, copyrights, legs, overviewPolyline];
}

class Bounds {
  Bounds({
    required this.northeast,
    required this.southwest,
  });
  late final Northeast northeast;
  late final Southwest southwest;

  Bounds.fromJson(Map<String, dynamic> json) {
    northeast = Northeast.fromJson(json['northeast']);
    southwest = Southwest.fromJson(json['southwest']);
  }
}

class Northeast {
  Northeast({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  Northeast.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}

class Southwest {
  Southwest({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  Southwest.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}

class Legs {
  Legs({
    required this.distance,
    required this.duration,
    required this.endAddress,
    required this.endLocation,
    required this.startAddress,
    required this.startLocation,
  });
  late final Distance distance;
  late final Duration duration;
  late final String endAddress;
  late final EndLocation endLocation;
  late final String startAddress;
  late final StartLocation startLocation;

  Legs.fromJson(Map<String, dynamic> json) {
    distance = Distance.fromJson(json['distance']);
    duration = Duration.fromJson(json['duration']);
    endAddress = json['end_address'];
    endLocation = EndLocation.fromJson(json['end_location']);
    startAddress = json['start_address'];
    startLocation = StartLocation.fromJson(json['start_location']);
  }
}

class Distance {
  Distance({
    required this.text,
    required this.value,
  });
  late final String text;
  late final int value;

  Distance.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }
}

class Duration {
  Duration({
    required this.text,
    required this.value,
  });
  late final String text;
  late final int value;

  Duration.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }
}

class EndLocation {
  EndLocation({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  EndLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}

class StartLocation {
  StartLocation({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  StartLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}

class OverviewPolyline {
  OverviewPolyline({
    required this.points,
  });
  late final String points;

  OverviewPolyline.fromJson(Map<String, dynamic> json) {
    points = json['points'];
  }
}
