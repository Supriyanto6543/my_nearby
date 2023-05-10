import 'package:equatable/equatable.dart';
import 'package:my_restaurant/features/domain/entities/result_entity.dart';

import 'geometry_model.dart';

class ResultModel extends Equatable {
  ResultModel({
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

  ResultModel.fromJson(Map<String, dynamic> json) {
    businessStatus = json['business_status'];
    geometry = GeometryModel.fromJson(json['geometry']);
    icon = json['icon'];
    iconBackgroundColor = json['icon_background_color'];
    iconMaskBaseUri = json['icon_mask_base_uri'];
    name = json['name'];
    placeId = json['place_id'];
    json['rating'] != null
        ? rating = double.parse(json['rating'].toString())
        : rating = null;
    reference = json['reference'];
    scope = json['scope'];
    types = List.castFrom<dynamic, String>(json['types']);
    json['user_ratings_total'] != null
        ? userRatingsTotal = json['user_ratings_total']
        : userRatingsTotal = null;
    vicinity = json['vicinity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['business_status'] = businessStatus;
    _data['geometry'] = geometry.toJson();
    _data['icon'] = icon;
    _data['icon_background_color'] = iconBackgroundColor;
    _data['icon_mask_base_uri'] = iconMaskBaseUri;
    _data['name'] = name;
    _data['place_id'] = placeId;
    _data['rating'] = rating;
    _data['reference'] = reference;
    _data['scope'] = scope;
    _data['types'] = types;
    _data['user_ratings_total'] = userRatingsTotal;
    _data['vicinity'] = vicinity;
    return _data;
  }

  ResultEntity toEntity() => ResultEntity(
      businessStatus: businessStatus,
      geometry: geometry,
      icon: icon,
      iconBackgroundColor: iconBackgroundColor,
      iconMaskBaseUri: iconMaskBaseUri,
      name: name,
      placeId: placeId,
      rating: rating,
      reference: reference,
      scope: scope,
      types: types,
      userRatingsTotal: userRatingsTotal,
      vicinity: vicinity);

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
