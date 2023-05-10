import 'package:equatable/equatable.dart';
import 'package:my_restaurant/features/data/model/location_model.dart';

class GeometryModel extends Equatable {
  GeometryModel({
    required this.location,
  });
  late final LocationModel location;

  GeometryModel.fromJson(Map<String, dynamic> json) {
    location = LocationModel.fromJson(json['location']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['location'] = location;
    return _data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [location];
}
