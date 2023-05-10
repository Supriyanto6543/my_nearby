import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_restaurant/common/app_permission_enum.dart';
import 'package:my_restaurant/common/common_shared.dart';
import 'package:my_restaurant/common/db_helper.dart';

import '../../../data/model/local_place_model.dart';

part 'account_place_state.dart';

class AccountPlaceCubit extends Cubit<AccountPlaceState> {
  AccountPlaceCubit(this.database) : super(AccountPlaceInitial());

  final DbHelper database;

  fetchAllData() async {
    final result = await database.getAllLocalPlace();
    List<LocalPlaceModel> data =
        result.map((e) => LocalPlaceModel.fromJson(e)).toList();
    emit(AccountPlaceLoaded(data, AppPermissionEnum.approved));
  }

  Future useAddress(LocalPlaceModel local) async {
    if (state is AccountPlaceLoaded) {
      final myState = state as AccountPlaceLoaded;
      CommonShared.currentPosition(local.lat, local.long, local.address);
      emit(AccountPlaceLoaded(myState.list, AppPermissionEnum.nothing));
    }
  }

  Future<int> addLocalPlace(LocalPlaceModel local) async {
    var list = LocalPlaceModel(
        address: local.address, lat: local.lat, long: local.long);
    await database.addLocalPlace(list);
    return 200;
  }
}
