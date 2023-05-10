import '../.env.dart';

class Constant {
  static const String baseUrl = "https://maps.googleapis.com/maps/api";
  static const String nearby = "/place/nearbysearch/json";
  static const String keyword = "keyword=";
  static const String location = "location=";
  static const String radius = "&radius=5000&type=";
  static const String apiKey = "&key=$googleApiKey";
  static const String destination = "/directions/json?destination=";
  static const String origin = "&origin=";

  /*
    Table field
   */
  static const String tblSaveMode = "tbl_save_mode";

  static const String id = "id";
  static const String title = "name";
  static const String businessStatus = "business_status";
  static const String iconBackgroundColor = "icon_background_color";
  static const String iconMaskUri = "icon_mask_base_uri";
  static const String scope = "scope";
  static const String reference = "reference";
  static const String icon = "icon";
  static const String rating = "rating";
  static const String totalRating = "user_ratings_total";
  static const String description = "vicinity";
  static const String dateUpdate = "date_update";
  static const String geometryLat = "geometry_lat";
  static const String geometryLang = "geometry_lang";
  static const String types = "types";
  static const String geometry = "geometry";

  /*
    Table local place
   */

  static const String tblPlace = "tbl_place";

  static const String placeId = "place_id";
  static const String placeAddress = "place_address";
  static const String placeLat = "place_lat";
  static const String placeLong = "place_long";
}
