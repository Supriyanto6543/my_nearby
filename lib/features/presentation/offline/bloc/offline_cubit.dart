import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_restaurant/common/app_permission_enum.dart';
import 'package:my_restaurant/common/db_helper.dart';

import '../../../data/model/result_offline_model.dart';

part 'offline_state.dart';

class OfflineCubit extends Cubit<OfflineState> {
  OfflineCubit(this.dbHelper) : super(OfflineInitial());

  final DbHelper dbHelper;

  fetchOfflineData() async {
    final data = await dbHelper.getAllData();
    List<ResultOfflineModel> list =
        data.map((e) => ResultOfflineModel.fromJson(e)).toList();
    emit(OfflineLoaded(list, AppPermissionEnum.approved));
  }
}
