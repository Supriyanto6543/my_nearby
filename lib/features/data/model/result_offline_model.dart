import 'package:equatable/equatable.dart';

class ResultOfflineModel extends Equatable {
  late final String? geometryLat;
  late final String? geometryLang;
  late final String? name;
  late final String? icon;
  late final double? rating;
  late final String? reference;
  late final int? userRatingTotal;
  late final String? dateUpdate;
  late final String? vicinity;
  late final String? types;

  ResultOfflineModel(
      this.geometryLang,
      this.geometryLat,
      this.name,
      this.icon,
      this.rating,
      this.reference,
      this.userRatingTotal,
      this.dateUpdate,
      this.vicinity,
      this.types);

  @override
  // TODO: implement props
  List<Object?> get props => [
        geometryLat,
        geometryLang,
        name,
        icon,
        rating,
        reference,
        userRatingTotal,
        dateUpdate,
        vicinity,
        types
      ];

  ResultOfflineModel.fromJson(Map<String, dynamic> json) {
    json['geometry_lat'] != null
        ? geometryLat = json['geometry_lat']
        : geometryLat = null;
    json['geometry_lang'] != null
        ? geometryLang = json['geometry_lang']
        : geometryLang = null;
    json['name'] != null ? name = json['name'] : name = null;
    json['reference'] != null ? icon = json['icon'] : icon = null;
    json['rating'] != null
        ? rating = double.parse(json['rating'].toString())
        : rating = null;
    json['reference'] != null
        ? reference = json['reference']
        : reference = null;
    json['user_ratings_total'] != null
        ? userRatingTotal = int.parse(json['user_ratings_total'])
        : userRatingTotal = null;
    dateUpdate = json['date_update'];
    json['vicinity'] != null ? vicinity = json['vicinity'] : vicinity = null;
    json['types'] != null ? types = json['types'] : types = null;
  }
}
