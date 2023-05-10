import 'package:equatable/equatable.dart';
import 'package:my_restaurant/features/data/model/geometry_model.dart';

class ResultEntity extends Equatable {
  ResultEntity({
    required this.businessStatus,
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.name,
    required this.placeId,
    required this.rating,
    required this.reference,
    required this.scope,
    required this.types,
    required this.userRatingsTotal,
    required this.vicinity,
  });
  late final String businessStatus;
  late final GeometryModel geometry;
  late final String icon;
  late final String iconBackgroundColor;
  late final String iconMaskBaseUri;
  late final String name;
  late final String placeId;
  late final double? rating;
  late final String reference;
  late final String scope;
  late final List<String> types;
  late final int? userRatingsTotal;
  late final String vicinity;

  @override
  // TODO: implement props
  List<Object?> get props => [
        businessStatus,
        geometry,
        icon,
        iconBackgroundColor,
        iconMaskBaseUri,
        name,
        placeId,
        rating,
        reference,
        scope,
        types,
        userRatingsTotal,
        vicinity
      ];
}
