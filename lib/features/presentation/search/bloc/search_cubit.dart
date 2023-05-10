import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant/features/domain/entities/result_entity.dart';
import 'package:my_restaurant/features/domain/usecase/get_search.dart';

import '../../../../common/app_permission_enum.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.getSearch) : super(SearchInitial());
  final GetSearch getSearch;

  static final scaffold = GlobalKey<ScaffoldState>();
  static final inputSearch = TextEditingController();

  clearText() {
    emit(SearchLoaded.getList(
        list: [], page: 1, enumStatus: AppPermissionEnum.nothing, name: ""));
  }

  searchNearby(String input, String type) async {
    emit(SearchLoaded.getList(
        list: [], page: 1, enumStatus: AppPermissionEnum.search, name: ""));
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      emit(SearchError(
          message: "You are offline", enumStatus: AppPermissionEnum.offline));
    } else {
      if (input != "") {
        final result = await getSearch.execute(input, type);
        result.fold((error) {
          emit(SearchError(
              message: error.toString(),
              enumStatus: AppPermissionEnum.notFound));
        }, (success) {
          if (success.isNotEmpty) {
            emit(SearchLoaded.getList(
                list: success,
                page: 1,
                enumStatus: AppPermissionEnum.searched,
                name: ""));
          } else {
            emit(SearchLoaded.getList(
                list: success,
                page: 1,
                enumStatus: AppPermissionEnum.notFound,
                name: ""));
          }
        });
      } else {
        emit(SearchLoaded.getList(
            list: [],
            page: 1,
            enumStatus: AppPermissionEnum.nothing,
            name: ""));
      }
    }
  }
}
