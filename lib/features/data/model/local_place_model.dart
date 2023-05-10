import 'package:equatable/equatable.dart';
import 'package:my_restaurant/features/domain/entities/local_place_entity.dart';

class LocalPlaceModel extends Equatable {
  late final String address;
  late final String lat;
  late final String long;

  LocalPlaceModel(
      {required this.address, required this.lat, required this.long});

  LocalPlaceModel.fromJson(Map<String, dynamic> json) {
    address = json['place_address'];
    lat = json['place_lat'];
    long = json['place_long'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['place_address'] = address;
    _data['place_lat'] = lat;
    _data['place_long'] = long;
    return _data;
  }

  LocalPlaceEntity toEntity() =>
      LocalPlaceEntity(address: address, lat: lat, long: long);

  @override
  // TODO: implement props
  List<Object?> get props => [address, lat, long];
}
