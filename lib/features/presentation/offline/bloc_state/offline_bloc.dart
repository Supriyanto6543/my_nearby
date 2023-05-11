import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:my_restaurant/common/db_helper.dart';

import '../../../../common/app_permission_enum.dart';
import '../../../data/model/result_offline_model.dart';

part 'offline_event.dart';
part 'offline_state.dart';

class OfflineBloc extends Bloc<OfflineBlocEvent, OfflineBlocState> {
  OfflineBloc() : super(OfflineBlocInitial()) {
    final DbHelper dbHelper = DbHelper();

    on<OfflineEventList>((event, emit) async {
      // TODO: implement event handler
      final data = await dbHelper.getAllData();
      List<ResultOfflineModel> list =
          data.map((e) => ResultOfflineModel.fromJson(e)).toList();
      emit(OfflineBlocLoaded(list, AppPermissionEnum.approved));
    });
  }
}
