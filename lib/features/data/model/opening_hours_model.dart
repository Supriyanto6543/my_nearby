import 'package:equatable/equatable.dart';

class OpeningHoursModel extends Equatable {
  OpeningHoursModel({
    required this.openNow,
  });
  late final bool openNow;

  OpeningHoursModel.fromJson(Map<String, dynamic> json) {
    openNow = json['open_now'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['open_now'] = openNow;
    return _data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [openNow];
}
