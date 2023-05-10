import 'package:equatable/equatable.dart';

class LocalPlaceEntity extends Equatable {
  late final String address;
  late final String lat;
  late final String long;

  LocalPlaceEntity(
      {required this.address, required this.lat, required this.long});

  @override
  // TODO: implement props
  List<Object?> get props => [address, lat, long];
}
